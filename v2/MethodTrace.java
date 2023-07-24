package com.mycompany.myapp;

import java.io.*;
import java.util.*;
import java.util.concurrent.locks.*;
import java.util.concurrent.*;

public class MethodTrace {
    private static final ReadWriteLock fileLock = new ReentrantReadWriteLock();
    private static HashMap<String, String> methodMap = new HashMap<>();
    private static ArrayList<String> methods = new ArrayList<>();

    public static void writeTrace(String methodName) {
        try {
            fileLock.writeLock().lock();

            String[] props = methodMap.containsKey(methodName) ? methodMap.get(methodName).split("::") : new String[]{"0", "0"};
            long time = Long.parseLong(props[0]);
            long occurence = Long.parseLong(props[1]);
            // System.out.println(methodName + " " + time + " " + occurence);

            if (!methodMap.containsKey(methodName) || System.nanoTime() - time > 500_000_000L) {
                // get
                File filePath = new File("/sdcard/trace/trace.txt");

                // update
                if (!methodMap.containsKey(methodName)) 
                    methods.add(methodName);

                methodMap.put(methodName, String.valueOf(System.nanoTime()) + "::" + String.valueOf(occurence + 1));

                try {
                    // write
                    FileWriter fileWriter = new FileWriter(filePath);
                    BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);

                    // Write contents to file
                    for (String method : methods) {
                        bufferedWriter.write(method + "::" + String.valueOf(methodMap.get(method)));
                        bufferedWriter.newLine();
                    }

                    // Flush and close the writer
                    bufferedWriter.flush();
                    bufferedWriter.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }

            }else {
                methodMap.put(methodName, String.valueOf(System.nanoTime()) + "::" + String.valueOf(occurence + 1));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            fileLock.writeLock().unlock();
        }
    }
}
