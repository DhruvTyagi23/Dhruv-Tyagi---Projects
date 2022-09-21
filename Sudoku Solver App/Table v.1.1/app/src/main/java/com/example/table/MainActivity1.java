package com.example.table;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

public class MainActivity1 extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main1);
    }
    public void openActivity(View v){
        Toast.makeText(this, "If you are enjoying our app, Please consider giving us a Rating", Toast.LENGTH_SHORT).show();
        Intent intent = new Intent(this, MainActivity.class);
        startActivity(intent);
    }
    public void openActivity2(View v){
        Intent intent = new Intent(this, MainActivity2.class);
        startActivity(intent);
    }
}