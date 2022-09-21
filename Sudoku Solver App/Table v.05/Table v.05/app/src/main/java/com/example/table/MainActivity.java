package com.example.table;

import androidx.appcompat.app.AppCompatActivity;

import android.content.res.Resources;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
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

        requestWindowFeature(Window.FEATURE_NO_TITLE);
        getSupportActionBar().hide();

        setContentView(R.layout.activity_main);

    }

    public void select(View v){
        textView = findViewById(v.getId());
//        Toast.makeText(this, textView.getText().toString(), Toast.LENGTH_SHORT).show();
    }

    public void entry(View v){
        if(textView==null){
            Toast.makeText(this, "no element selected", Toast.LENGTH_SHORT).show();
            return;
        }
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

    public void refresh(View v){
        Sudoku sudoku = new Sudoku(9, 60);
        sudoku.fillValues();
        Resources r = getResources();
        String name = getPackageName();
        for(int i=1; i<10; i++){
            tb = findViewById(r.getIdentifier("tb" + i, "id", name));
            for(int j=0; j<9; j++){
                View v2 = tb.getVirtualChildAt(j);
                textView = findViewById(v2.getId());
                if(sudoku.mat[i-1][j]!=0)
                    textView.setText(String.valueOf(sudoku.getSudoku(i-1, j)));
                else
                    textView.setText("");
            }
        }
    }


}