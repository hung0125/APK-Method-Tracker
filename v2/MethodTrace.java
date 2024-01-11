package com.mycompany.myapp;

import java.io.*;
import java.util.*;
import java.util.concurrent.locks.*;
import java.util.concurrent.*;
import android.app.*;
import android.os.*;

public class MethodTrace {
    private static final ReadWriteLock fileLock = new ReentrantReadWriteLock();
    private static HashMap<String, Long[]> methodMap = new HashMap<>();
    private static HashMap<String, Boolean> runtimeDataMap = new HashMap<>();
    private static ArrayList<String> methods = new ArrayList<>();
	private static File docDir = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOCUMENTS);
	private static File filePath = new File(docDir, "/trace/trace.txt");
    private static File rtDataPath = new File(docDir, "/trace/runtimedump.txt");
    private static File dumpLock = new File(docDir, "/trace/lock"); 
    private static int dataLimitLength = 65535;

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
			
            Long[] props = methodMap.containsKey(methodName) ? methodMap.get(methodName) : new Long[]{0L, 0L};
            long time = props[0];
            long occurence = props[1];
            // System.out.println(methodName + " " + time + " " + occurence);

            if (!methodMap.containsKey(methodName) || System.nanoTime() - time > 500_000_000L) {
                // update
                if (!methodMap.containsKey(methodName)) 
                    methods.add(methodName);

                methodMap.put(methodName, new Long[]{System.nanoTime(), occurence + 1L});

                try {
                    // write
                    FileWriter fileWriter = new FileWriter(filePath);
                    BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);

                    // Write contents to file
                    for (String method : methods) {
                        bufferedWriter.write(method + "::" + String.valueOf(methodMap.get(method)[0]) + "::" + String.valueOf(methodMap.get(method)[1]));
                        bufferedWriter.newLine();
                    }

                    // Flush and close the writer
                    bufferedWriter.flush();
                    bufferedWriter.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }

            }else {
                methodMap.put(methodName, new Long[]{System.nanoTime(), occurence + 1L});
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            fileLock.writeLock().unlock();
        }
    }

    public static void writeRTData(String s) {
        if (dumpLock.exists() || s == null)
            return;
        
        StackTraceElement trace = new Throwable().fillInStackTrace().getStackTrace()[1];
        String fullFormat = String.format("@General| %s ==>\t%s", trace.toString(), s.substring(0, Math.min(s.length(), dataLimitLength)));

        writeData(fullFormat);
    }

    public static void writeRTData(String[] s) {
        if (dumpLock.exists() || s == null)
            return;

        String out = "{" + String.join(",", s) + "}";
        StackTraceElement trace = new Throwable().fillInStackTrace().getStackTrace()[1];
        String fullFormat = String.format("@General[]| %s ==>\t%s", trace.toString(), out.substring(0, Math.min(out.length(), dataLimitLength)));

        writeData(fullFormat);
    }

    public static void writeRTData(CharSequence cs) { // UI set text
        if (dumpLock.exists() || cs == null)
            return;
        String data = cs.toString();
        StackTraceElement trace = new Throwable().fillInStackTrace().getStackTrace()[1];
        String fullFormat = String.format("@UIText| %s ==>\t%s", trace.toString(), data.substring(0, Math.min(data.length(), dataLimitLength)));

        writeData(fullFormat);
    }

    public static void writeData(String fullFormat) {
        try {
            fileLock.writeLock().lock();
			
			// on reset
			if (rtDataPath.length() == 0) {
				runtimeDataMap = new HashMap<>();
			}

            if (!runtimeDataMap.containsKey(fullFormat)) {
                // update
                runtimeDataMap.put(fullFormat, true);

                try {
                    // write
                    FileWriter fileWriter = new FileWriter(rtDataPath, true);
                    BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);

                    // Write contents to file
                    bufferedWriter.write(fullFormat);
                    bufferedWriter.newLine();

                    // Flush and close the writer
                    bufferedWriter.flush();
                    bufferedWriter.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            fileLock.writeLock().unlock();
        }
    }
}