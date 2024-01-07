package com.mycompany.myapp;

import java.io.*;
import java.util.*;
import java.util.concurrent.locks.*;
import java.util.concurrent.*;

public class MethodTrace {
    private static final ReadWriteLock fileLock = new ReentrantReadWriteLock();
    private static HashMap<String, Long[]> methodMap = new HashMap<>();
    private static HashMap<String, Boolean> runtimeDataMap = new HashMap<>();
    private static ArrayList<String> methods = new ArrayList<>();
	private static File filePath = new File("/sdcard/trace/trace.txt");
    private static File rtDataPath = new File("/sdcard/trace/runtimedump.txt");
    private static File dumpLock = new File("/sdcard/trace/lock"); 

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

        try {
            fileLock.writeLock().lock();
			
			// on reset
			if (filePath.length() == 0) {
				runtimeDataMap = new HashMap<>();
			}

            StackTraceElement trace = new Throwable().fillInStackTrace().getStackTrace()[1];
            String fullFormat = String.format("%s ==> %s", trace.toString(), s.substring(0, Math.min(s.length(), 100)));
            // note that we deleted part of the string to protect efficiency

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

    public static void writeRTArrayData(String[] s) {
        if (dumpLock.exists() || s == null)
            return;
    }
}
