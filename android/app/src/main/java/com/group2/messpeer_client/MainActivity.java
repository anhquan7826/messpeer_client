package com.group2.messpeer_client;

import android.os.Build;
import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;
import com.group2.messpeer_client.connection.Connection;
import java.util.Objects;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    Connection connection;

    public static final String CHANNEL = "com.group2.messpeer_client/communication";

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
                    String username = call.argument("username");
                    String groupChatName = call.argument("groupChatName");
                    String groupChatID = call.argument("groupChatID");
                    String message = call.argument("messageObject");
                    String password = call.argument("password");
                    String command = "";
                    switch (call.method) {
                        case "authenticate":
                            result.success(connection.authenticate(username, password));
                            break;
                        case "getMessage":
                            result.success(connection.pollMessages());
                            break;
                        case "sendMessage":
                            // TODO: fix this
                            //connection.sendMessage(JsonMaker.MessagesJson(username, groupChatID, message, getCurrentDateTime()));
                            break;
/*                        case "groupChatCreate":
                            command = "GROUP_CHAT_CREATE:" + groupChatName;
                            result.success(querryCommand(command));
                            break;
                        case "groupChatDelete":
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
