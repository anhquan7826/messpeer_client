package com.group2.messpeer_client.connection;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

public class Connection extends Thread {
    private final String serverIP = "localhost";
    private final int serverPort = 43896;

    private Socket socket;
    private BufferedReader bufferedReader;
    private PrintWriter printWriter;

    private ServerCommunicator serverCommunicator;

    private boolean authenticated;

    public Connection() {
        authenticated = false;
        this.serverCommunicator = new ServerCommunicator(this);
    }

    private boolean createConnection() {
        try {
            socket = new Socket(serverIP, serverPort);
            System.out.println("Established a connection to server at " + serverIP + ":" + serverPort);
            bufferedReader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            printWriter = new PrintWriter(socket.getOutputStream(), true);
        } catch (IOException e) {
            socket = null;
        }
        return true;
    }

    public boolean authenticate(String username, String password) {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    printWriter.println("INITIAL_MESSAGE:" + username + " " + password.hashCode());
                    String message = bufferedReader.readLine().trim();
                    if (message.equals("AUTHENTICATE_SUCCESS")) {
                        authenticated = true;
                    }
                } catch (IOException e) {
                    authenticated = false;
                }
            }
        });
        thread.start();
        try {
            thread.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        return isAuthenticated();
    }

    public String getMessage() {
        try {
            return bufferedReader.readLine().trim();
        } catch (IOException e) {
            return null;
        }
    }

    public void sendMessage(String message) {
        new Thread(new Runnable() {
            @Override
            public void run() {
                printWriter.println(message);
            }
        }).start();
    }

    @Override
    public void run() {
        while (!createConnection()) {
            System.out.println("Cannot establish a connection to server. Retrying...");
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        serverCommunicator.start();
    }

    public ServerCommunicator getServerCommunicator() throws Exception {
        if (!this.isAlive()) {
            throw new Exception("Connection is not running!");
        }
        return serverCommunicator;
    }

    public boolean isAuthenticated() {
        return authenticated;
    }
}
