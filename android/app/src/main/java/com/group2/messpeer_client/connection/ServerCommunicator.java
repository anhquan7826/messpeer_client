package com.group2.messpeer_client.connection;

import java.io.IOException;
import java.util.LinkedList;
import java.util.Observer;
import java.util.Queue;

public class ServerCommunicator extends Thread {
    private Connection connection;
    private Queue<String> commandQueue;
    private Queue<String> resultQueue;

    ServerCommunicator(Connection connection) {
        this.connection = connection;
        commandQueue = new LinkedList<String>();
        resultQueue = new LinkedList<String>();
    }

    @Override
    public void run() {
        Thread resultThread = new Thread(new Runnable() {
            @Override
            public void run() {
                new Thread(new Runnable() {
                    @Override
                    public void run() {
                        String result = null;
                        while (result == null || result.equals("")) {
                             result = connection.getMessage();
                        }
                        resultQueue.offer(result);
                    }
                }).start();
            }
        });

        new Thread(new Runnable() {
            @Override
            public void run() {
                while (true) {
                    String command = commandQueue.poll();
                    if (command == null) {
                        continue;
                    }
                    if (connection.isAuthenticated()) {
                        // TODO: execute commands.
                        connection.sendMessage(command);
                        resultThread.start();
                        try {
                            resultThread.join(20000);
                        } catch (InterruptedException e) {
                            System.out.println("No result with command " + command);
                        }
                    }
                }
            }
        }).start();
    }


}
