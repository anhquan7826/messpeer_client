package com.group2.messpeer_client;

import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.group2.messpeer_client.Json_in_out.JsonMaker;
import com.group2.messpeer_client.connection.Connection;
import com.group2.messpeer_client.connection.ServerCommunicator;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    Connection connection = new Connection();
    ServerCommunicator serverCommunicator;

    public static final String CHANNEL = "com.group2.messpeer_client/communication";

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        connection.start();
        try {
            serverCommunicator = connection.getServerCommunicator();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler(
                (call, result) -> {
                    if (call.method.equals("authenticate")) {
                        String username = call.argument("username");
                        String password = call.argument("password");
                        result.success(connection.authenticate(username, password));
                    } else if (call.method.equals("sendMessage")) {
                        String username = call.argument("username");
                        String groupChatID = call.argument("groupChatID");
                        String message = call.argument("messageObject");
                        // TODO: turn raw message to json object
                        serverCommunicator.getCommandQueue().add(JsonMaker.MessagesJson(username, groupChatID, message, "22-11-22"));
                    } else if (call.method.equals("groupChatCreate")) {
                        String groupChatID = call.argument("groupChatID");
                        serverCommunicator.getCommandQueue().add(JsonMaker.GroupJson(groupChatID));
                    } else if (call.method.equals("groupChatDelete")) {
                        String groupChatID = call.argument("groupChatID");
                        serverCommunicator.getCommandQueue().add(JsonMaker.GroupJson(groupChatID));
                    } else if (call.method.equals("groupChatAdd")) {
                        String username = call.argument("username");
                        serverCommunicator.getCommandQueue().add(JsonMaker.UserJson(username));
                    } else if (call.method.equals("groupChatKick")) {
                        String username = call.argument("username");
                        serverCommunicator.getCommandQueue().add(JsonMaker.UserJson(username));
                    } else if (call.method.equals("groupChatChangeHost")) {
                        String username = call.argument("username");
                        serverCommunicator.getCommandQueue().add(JsonMaker.UserJson(username));
                    }
                }
        );
    }
}
