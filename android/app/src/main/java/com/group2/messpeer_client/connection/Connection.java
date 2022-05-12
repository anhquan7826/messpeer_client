package com.group2.messpeer_client.connection;

import com.group2.messpeer_client.state.Utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Queue;
import java.util.concurrent.TimeUnit;

import io.flutter.Log;

public class Connection {
    private static final String serverIP = "10.0.2.2";
    private static final int serverPort = 43896;

    private Socket socket;
    private BufferedReader bufferedReader;
    private PrintWriter printWriter;

    private HashMap<String, String> credential;

    private boolean connected;
    private String authenticated;

    private final Queue<String> results;
    private final Queue<String> messages;

    public Connection() {
        connected = false;
        authenticated = Utils.CallState.IDLE;

        results = new LinkedList<>();
        messages = new LinkedList<>();

        credential = new HashMap<>();

        connect();
        if (connected) {
            startCommunicate();
        }
    }

    private void connectionTest() {
        connected = false;
        Log.d("TAG", "Lost connection to server! Reconnecting...");
        connect();
    }

    private void connect() {
        new Thread(new Runnable() {
            @Override
            public void run() {
                while (!connected) {
                    try {
                        socket = new Socket(serverIP, serverPort);
                        Log.d("TAG", "Established a connection to server at " + serverIP + ":" + serverPort);
                        bufferedReader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
                        printWriter = new PrintWriter(socket.getOutputStream(), true);
                        connected = true;
                    } catch (IOException e) {
                        connected = false;
                        Log.d("TAG", "Cannot establish a connection to server at " + serverIP + ":" + serverPort + ". Retrying...");
                        try {
                            TimeUnit.MILLISECONDS.sleep(500);
                        } catch (InterruptedException interruptedException) {
                            Log.d("TAG", interruptedException.toString());
                        }
                    }
                }
                if (credential.containsKey("username") && credential.containsKey("password")) {
                    authenticate(credential.get("username"), credential.get("password"));
                }
                startCommunicate();
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
                        if (message == null) {
                            connectionTest();
                            continue;
                        }
                        Log.d("TAG", "Server " + "[" + i++ + "]" + ": " + message);
                        if (message.startsWith("RECEIVE_MESSAGE")) {
                            messages.add(message);
                        } else {
                            results.add(message);
                        }
                    } catch (IOException e) {
                        connectionTest();
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

    public String authenticate(String username, String password) {
        if (authenticated.equals(Utils.CallState.TRUE) || authenticated.equals(Utils.CallState.FALSE)) {
            String temp = authenticated;
            authenticated = Utils.CallState.IDLE;
            return temp;
        }
        if (authenticated.equals(Utils.CallState.IDLE)) {
            authenticated = Utils.CallState.CALLING;
            credential.put("username", username);
            credential.put("password", password);
            sendMessage("INITIAL_MESSAGE:" + Utils.Json.toJson(credential));
            new Thread(new Runnable() {
                @Override
                public void run() {
                    while (true) {
                        String result = pollResults();
                        if (result == null) continue;
                        if (result.equals("AUTHENTICATE_SUCCESS")) {
                            authenticated = Utils.CallState.TRUE;
                            break;
                        } else if (result.equals("AUTHENTICATE_FAILED")) {
                            authenticated = Utils.CallState.FALSE;
                            break;
                        }
                    }
                }
            }).start();
        }
        return authenticated;
    }

    private Object getGroupChatListState = Utils.CallState.IDLE;
    public Object getGroupChatList() {
        if (!getGroupChatListState.equals(Utils.CallState.CALLING) && !getGroupChatListState.equals(Utils.CallState.IDLE)) {
            Object temp = getGroupChatListState;
            getGroupChatListState = Utils.CallState.IDLE;
            return temp;
        }
        if (getGroupChatListState.equals(Utils.CallState.IDLE)) {
            getGroupChatListState = Utils.CallState.CALLING;
            sendMessage("GET_GROUPCHAT_LIST");
            new Thread(new Runnable() {
                @Override
                public void run() {
                    while (true) {
                        String result = pollResults();
                        if (result == null) continue;
                        if (result.startsWith("GET_GROUPCHAT_LIST_OK")) {
                            // getGroupChatListState = result.replaceFirst("GET_GROUPCHAT_LIST_OK:", "");
                            getGroupChatListState = Utils.Json.toHashMap(result.replaceFirst("GET_GROUPCHAT_LIST_OK:", ""));
                            break;
                        }
                        if (result.startsWith("GET_GROUPCHAT_LIST_ERROR")) {
                            getGroupChatListState = Utils.CallState.ERROR;
                            break;
                        }
                    }
                }
            }).start();
        }
        return getGroupChatListState;
    }

    public boolean isConnected() {
        return connected;
    }

    public String isAuthenticated() {
        return authenticated;
    }

    public String pollResults() {
        return results.poll();
    }

    public String pollMessages() {
        return messages.poll();
    }
}