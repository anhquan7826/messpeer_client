package com.group2.messpeer_client.state;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import java.util.HashMap;
import java.util.Random;

public class Utils {
    public static class CallState {
        public static final String CALLING = "CALLING";
        public static final String IDLE = "IDLE";
        public static final String TRUE = "TRUE";
        public static final String FALSE = "FALSE";
        public static final String ERROR = "ERROR";
    }

    public static class Json {
        public static String toJson(HashMap<String, String> map) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.putAll(map);
            return jsonObject.toJSONString();
        }

        public static HashMap<String, String> toHashMap(String jsonString) {
            return (HashMap<String, String>) JSONValue.parse(jsonString);
        }
    }

    private static char[] values = {
            '1', '2', '3', '4', '5', '6', '7', '8', '9', '0',
            'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
            'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
    };
    private static Random random = new Random();
    public static String generate(int length) {
        StringBuilder randomString = new StringBuilder();
        for (int i = 0; i < length; i++) {
            randomString.append(values[random.nextInt(values.length)]);
        }
        return randomString.toString();
    }
}
