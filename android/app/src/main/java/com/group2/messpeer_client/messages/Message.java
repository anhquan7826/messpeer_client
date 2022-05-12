package com.group2.messpeer_client.messages;

import android.annotation.SuppressLint;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Message {
    private String username;
    private Date timestamp;
    private String groupID;
    private String message;

    @SuppressLint("SimpleDateFormat")
    public Message(String groupID, String username, String timestamp, String message) throws ParseException {
        this.groupID = groupID;
        this.username = username;
        this.timestamp = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss.SSS").parse(timestamp);
        this.message = message;
    }

    public Message(String json) {
        // TODO: convert to object
    }

    public String toJson() {
        // TODO: convert to json
        return null;
    }
}
