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
    Sudoku sudoku = new Sudoku(9, 60);
    Sudoku userInp = new Sudoku(9,60);
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        requestWindowFeature(Window.FEATURE_NO_TITLE);
        getSupportActionBar().hide();

        setContentView(R.layout.activity_main);

    }

    public void select(View v){
        textView = findViewById(v.getId());
    }

    public void userInp(String n)
    {
        String id=getResources().getResourceEntryName(textView.getId());
        char r = id.charAt(2);
        char c = id.charAt(3);
        int num = Integer.parseInt(n);
        int r1 = Integer.parseInt(String.valueOf(r));
        int c1 = Integer.parseInt(String.valueOf(c));
        userInp.addToPos(r1,c1,num);
        // Toast.makeText(this, "row " + r + " column " + c + " num " + num, Toast.LENGTH_SHORT).show();
    }

    public void entry(View v){
        if(textView==null){
            Toast.makeText(this, "no element selected", Toast.LENGTH_SHORT).show();
            return;
        }
        button = findViewById(v.getId());
        String s = button.getText().toString();
        userInp(s);
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

    //simplified solver
    public void solve(View v)
    {
        if (sudoku.solveSudoku())
        {
            Resources r = getResources();
            String name = getPackageName();
            for (int i = 1; i < 10; i++)
            {
                tb = findViewById(r.getIdentifier("tb" + i, "id", name));
                for (int j = 0; j < 9; j++)
                {
                    View v2 = tb.getVirtualChildAt(j);
                    textView = findViewById(v2.getId());
                        textView.setText(String.valueOf(sudoku.getSudoku(i-1, j)));
                    Toast.makeText(this, "User input was wrong , solved without them", Toast.LENGTH_SHORT).show();
                }
            }
        }

    }

    //Solving with user input
    public void solveUserInput(View v)
    {
        userInp.addTwoMatrix(userInp,sudoku);
        if (sudoku.solveSudoku())
        {
            Resources r = getResources();
            String name = getPackageName();
            for (int i = 1; i < 10; i++)
            {
                tb = findViewById(r.getIdentifier("tb" + i, "id", name));
                for (int j = 0; j < 9; j++)
                {
                    View v2 = tb.getVirtualChildAt(j);
                    textView = findViewById(v2.getId());
                    textView.setText(String.valueOf(userInp.getSudoku(i-1, j)));
                    Toast.makeText(this, "Solved with User Input", Toast.LENGTH_SHORT).show();
                }
            }
        }
        //else solve();

    }

}