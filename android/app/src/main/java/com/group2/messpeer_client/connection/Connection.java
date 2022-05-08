package com.group2.messpeer_client.connection;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.LinkedList;
import java.util.Objects;
import java.util.Queue;

import io.flutter.Log;

public class Connection {
    private static final String serverIP = "192.168.0.101";
    private static final int serverPort = 43896;

    private Socket socket;
    private BufferedReader bufferedReader;
    private PrintWriter printWriter;

    private boolean connected;
    private boolean authenticated;

    private Queue<String> results;
    private Queue<String> messages;

    public Connection() {
        connected = false;
        authenticated = false;

        results = new LinkedList<>();
        messages = new LinkedList<>();

        connect();
        if (connected)  {
            startCommunicate();
        }
    }

    private void connectionTest() {
        while (true) {
            try {
                if (socket.getInputStream().available() < 0) {
                    connected = false;
                    System.out.println("Lost connection to server! Retrying...");
                    connect();
                    break;
                }
            } catch (IOException e) {
                connected = false;
                System.out.println("Lost connection to server! Retrying...");
                connect();
                break;
            }
        }
    }

    private void connect() {
        new Thread(new Runnable() {
            @Override
            public void run() {
                while (!connected) {
                    try {
                        socket = new Socket(serverIP, serverPort);
                        Log.d("TAG", "Established connection to server at " + serverIP + ":" + serverPort);
                        bufferedReader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
                        printWriter = new PrintWriter(socket.getOutputStream(), true);
                        connected = true;
                    } catch (IOException e) {
                        connected = false;
                        Log.d("TAG", "Cannot establish to server at " + serverIP + ":" + serverPort + ". Retrying...");
                        try {
                            Thread.sleep(500);
                        } catch (InterruptedException interruptedException) {
                            interruptedException.printStackTrace();
                        }
                    }
                }
                connectionTest();
            }
        }).start();
    }

    public void startCommunicate() {
        new Thread(new Runnable() {
            @Override
            public void run() {
                int i = 0;
                while (connected) {
                    try {
                        String message = bufferedReader.readLine();
                        Log.d("TAG", "Server " + i++ + ": " + message);
                        if (message.startsWith("RECEIVE_MESSAGE")) {
                            messages.add(message);
                        } else {
                            results.add(message);
                        }
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }).start();
    }

    public void sendMessage(String message) {
        new Thread(new Runnable() {
            @Override
            public void run() {
                printWriter.println(message);
            }
        }).start();
    }

   public boolean authenticate(String username, String password) {
       sendMessage("INITIAL_MESSAGE:" + username + " " + password.hashCode());
       try {
           Thread.sleep(1000);
       } catch (InterruptedException e) {
           Log.d("TAG", e.toString());
       }
       while (results.size() != 0) {
           String result = pollResults();
           if (result.equals("AUTHENTICATE_SUCCESS")) {
               Log.d("TAG", "AUTHENTICATE_SUCCESS");
               authenticated = true;
               return true;
           } else if (result.equals("AUTHENTICATE_FAILED")) {
               Log.d("TAG", "AUTHENTICATE_FAILED");
               authenticated = false;
               return false;
           }
       }
       return false;
   }

   public boolean isConnected() {
        return connected;
   }

    public String pollResults() {
        return results.poll();
    }

    public String pollMessages() {
        return messages.poll();
    }
}