package com.example.listes;

import androidx.appcompat.app.AppCompatActivity;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.Socket;
import java.net.UnknownHostException;
import android.os.Bundle;
import android.os.StrictMode;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.TextView;


public class MainActivity extends AppCompatActivity {

    private TextView message;
    private CheckBox checkBox2;
    private CheckBox checkBox3;
    private Button bouton;
    private CheckBox CheckBox;


    public int reagir (View v){
        StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
        StrictMode.setThreadPolicy(policy);

        String liste= CheckBox.getText().toString();

        Socket sockfd;
        DataOutputStream enSortie;
        DataInputStream enEntree;
        int portno = 5001;
        byte[] buffer;

        try {


            sockfd = new Socket("10.0.2.2", portno);

            enSortie = new DataOutputStream(sockfd.getOutputStream());
            buffer = liste.getBytes();
            enSortie.write(buffer, 0, buffer.length);

            enEntree = new DataInputStream(sockfd.getInputStream());
            buffer = new byte[256];
            int n = enEntree.read(buffer, 0, 255);
            String names = new String(buffer, 0, n);
            System.out.println("Liste = " + names);

            message.setText("La Liste est "+ names );

            sockfd.close();

        } catch (UnknownHostException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return 0;
    }



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

            CheckBox = (CheckBox) findViewById(R.id.checkBox);
            CheckBox = (CheckBox) findViewById(R.id.checkBox2);
            CheckBox = (CheckBox) findViewById(R.id.checkBox3);
            bouton = (Button) findViewById(R.id.button);
            message = (TextView) findViewById(R.id.textView6);



    }
}









