package com.example.table;

import androidx.appcompat.app.AppCompatActivity;

import android.content.res.Resources;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TableRow;
import android.widget.TextView;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {
    TextView textView;
    Button button;
    TableRow tb;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

    }

    public void select(View v){
        textView = findViewById(v.getId());
//        Toast.makeText(this, textView.getText().toString(), Toast.LENGTH_SHORT).show();
    }

    public void entry(View v){
        button = findViewById(v.getId());
        String s = button.getText().toString();
        textView.setText(s);
    }

    public void clearAll(View v){
        Resources r = getResources();
        String name = getPackageName();
        for(int i=1; i<10; i++){
            tb = findViewById(r.getIdentifier("tb" + i, "id", name));
            for(int j=0; j<9; j++){
                View v2 = tb.getVirtualChildAt(j);
                textView = findViewById(v2.getId());
                textView.setText("");
            }
        }
    }


}