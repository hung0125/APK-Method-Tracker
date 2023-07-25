package com.mycompany.myapp;

import java.io.*;
import java.util.*;
import java.util.concurrent.locks.*;
import java.util.concurrent.*;

public class MethodTrace {
    private static final ReadWriteLock fileLock = new ReentrantReadWriteLock();
    private static HashMap<String, Long[]> methodMap = new HashMap<>();
    private static ArrayList<String> methods = new ArrayList<>();
	private static File filePath = new File("/sdcard/trace/trace.txt");

    public static void writeTrace(String methodName) {
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
}
