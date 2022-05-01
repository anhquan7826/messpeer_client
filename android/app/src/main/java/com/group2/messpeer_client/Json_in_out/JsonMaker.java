package com.group2.messpeer_client.Json_in_out;

import org.json.simple.JSONObject;

import java.io.FileWriter;
import java.io.IOException;

public class JsonMaker {

    /*
    public static HashMap<String, String> ReadJson(String path) {
        HashMap<String, String> output = new HashMap<>();

        JSONParser jsonParser = new JSONParser();

        try (FileReader reader = new FileReader("src/main/java/output.json"))
        {
            Object obj = jsonParser.parse(reader);

            JSONArray employeeList = (JSONArray) obj;
            System.out.println(employeeList);

        } catch (ParseException | IOException e) {
            e.printStackTrace();
        }
        return output;
    }*/

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

    public static String GroupJson(String groupID) {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("groupID", groupID);         //tao noi dung cho json
        try {
            FileWriter file = new FileWriter("src/main/java/group.json");  //sua thu muc ghi ra o cho nay
            file.write(jsonObject.toJSONString());
            file.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return jsonObject.toJSONString();
    }

    public static String UserJson(String userID) {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("userID", userID);         //tao noi dung cho json
        try {
            FileWriter file = new FileWriter("src/main/java/user.json");  //sua thu muc ghi ra o cho nay
            file.write(jsonObject.toJSONString());
            file.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return jsonObject.toJSONString();
    }

    public static void main(String[] args) {
        MessagesJson("123456", "1357", "co cai ccc", "22-11-2022");
        GroupJson("123456");
        UserJson("1357");
    }
}


