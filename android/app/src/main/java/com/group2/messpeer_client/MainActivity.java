package com.group2.messpeer_client;

import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

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
            connection.getServerCommunicator();
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
                        result.success(connection.authenticate(call.argument("username"), call.argument("password")));
                    } else if (call.method.equals("sendMessage")) {
                        String username = call.argument("username");
                        String groupID = call.argument("groupID");
                        String message = call.argument("message");
                        // TODO: turn raw message to json object
                    } else if (call.method.equals("createGroupChat")) {
                        String name = call.argument("name");
                        
                    }
                }
        );
    }
}
