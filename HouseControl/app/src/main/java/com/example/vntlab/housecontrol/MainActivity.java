package com.example.vntlab.housecontrol;

import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.CompoundButton;
import android.widget.ImageView;
import android.widget.Switch;
import android.widget.TextView;
import android.widget.ToggleButton;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        switchState();
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    /*Trata acoes baseado no estado do switch*/
    public void switchState(){
        Switch toggle = (Switch) findViewById(R.id.mySwitch);
        toggle.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if(isChecked){
                    ImageView myImage=(ImageView)findViewById(R.id.background_status_imagem);
                    myImage.setImageResource(R.drawable.bgon);
                    TextView myText=(TextView)findViewById(R.id.status_luz_texto);
                    myText.setText(R.string.status_luz_ligada);
                    ImageView myImage2=(ImageView)findViewById(R.id.status_lampada);
                    myImage2.setImageResource(R.drawable.icon_luz_on);
                }else{
                    ImageView myImage=(ImageView)findViewById(R.id.background_status_imagem);
                    myImage.setImageResource(R.drawable.bgoff);
                    TextView myText=(TextView)findViewById(R.id.status_luz_texto);
                    myText.setText(R.string.status_luz_desligada);
                    ImageView myImage2=(ImageView)findViewById(R.id.status_lampada);
                    myImage2.setImageResource(R.drawable.icon_luz_off);
                }
            }
        });
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
}
