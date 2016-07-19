package androidcourse.venturus.org.br.androidcourse_firstexample;

import android.content.Context;
import android.content.SharedPreferences;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;


public class MainActivity extends AppCompatActivity {
    private int count = 0;
    private SharedPreferences myPrefs;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        myPrefs = getSharedPreferences(getString(R.string.arquivo_preferencias), Context.MODE_PRIVATE);
        TextView label = (TextView) findViewById(R.id.label_id);
        count = myPrefs.getInt("count", 0);
        label.setText(getString(R.string.label_name, count));
    }

    public void likedAction(View view){
        TextView label = (TextView) findViewById(R.id.label_id);
        count++;
        label.setText(getString(R.string.label_name, count));
    }

    protected void onPause(){
        super.onPause();
        SharedPreferences.Editor editor = myPrefs.edit();
        Log.d("debug", "count: "+ count);
        editor.putInt("count", count);
        editor.apply();
    }
}
