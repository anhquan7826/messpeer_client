package com.group2.messpeer_client.Json_in_out;

import org.json.simple.JSONObject;

import java.io.FileWriter;
import java.io.IOException;

public class JsonMaker {
    public static String MessagesJson(String userID, String groupID, String message, String time) {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("groupID", groupID);         //tao noi dung cho json
        jsonObject.put("UserID", userID);           //tao noi dung cho json
        jsonObject.put("Message", message);         //tao noi dung cho json
        jsonObject.put("Time", time);               //tao noi dung cho json
        try {
            FileWriter file = new FileWriter("src/main/java/messages.json"); //sua thu muc ghi ra o cho nay
            file.write(jsonObject.toJSONString());
            file.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return jsonObject.toJSONString();
    }
}


