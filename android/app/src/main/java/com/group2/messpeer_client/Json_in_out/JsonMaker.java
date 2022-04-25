package com.group2.messpeer_client.Json_in_out;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;

public class JsonMaker {

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
    }

    public static void MakeJson(String groupID, String userID, String message, String time) {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("groupID", groupID);         //tao noi dung cho json
        jsonObject.put("UserID", userID);           //tao noi dung cho json
        jsonObject.put("Message", message);         //tao noi dung cho json
        jsonObject.put("Time", time);               //tao noi dung cho json
        try {
            FileWriter file = new FileWriter("src/main/java/output.json"); //sua thu muc ghi ra o cho nay
            file.write(jsonObject.toJSONString());
            file.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        System.out.println("JSON file created: "+jsonObject);
    }

    public static void main(String[] args) {
        MakeJson("123456", "1357", "co cai ccc", "22-11-2022");
    }
}


