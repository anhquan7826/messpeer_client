package com.group2.messpeer_client;

import android.os.Build;
import android.os.Bundle;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;
import com.group2.messpeer_client.connection.Connection;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    Connection connection;

    public static final String CHANNEL = "com.group2.messpeer_client";

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        connection = new Connection();
    }

    @RequiresApi(api = Build.VERSION_CODES.O)
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler(
                (call, result) -> {
                    switch (call.method) {
                        case "log":
                            Log.d("TAG", call.argument("log"));
                            break;
                        case "authenticate":
                            String password = call.argument("password");
                            String username = call.argument("username");
                            assert password != null;
                            String rs = connection.authenticate(username, Integer.toString(password.hashCode()));
                            result.success(rs);
                            break;
                        case "isAuthenticated":
                            result.success(connection.isAuthenticated());
                            break;
                        case "getMessage":
                            result.success(connection.pollMessages());
                            break;
                        case "getGroupChatList":
                            result.success(connection.getGroupChatList());
                            break;
                        case "sendMessage":
                            String message = call.argument("message");
                            connection.sendMessage("SEND_MESSAGE:" + message);
                            break;
                        case "groupChatCreate":
                            command = "GROUP_CHAT_CREATE:" + groupChatName;
                            result.success(querryCommand(command));
                            break;
/*                        case "groupChatDelete":
                            command = "GROUP_CHAT_DELETE:" + groupChatID;
                            result.success(querryCommand(command));
                            break;
                        case "groupChatAdd":
                            command = "GROUP_CHAT_ADD:" + username + " " + groupChatID;
                            result.success(querryCommand(command));
                            break;
                        case "groupChatKick":
                            command = "GROUP_CHAT_KICK:" + username + " " + groupChatID;
                            result.success(querryCommand(command));
                            break;
                        case "groupChatChangeHost":
                            command = "GROUP_CHAT_CHANGE_HOST:" + username + " " + groupChatID;
                            result.success(querryCommand(command));
                            break;*/
                    }
                }
        );
    }
}
