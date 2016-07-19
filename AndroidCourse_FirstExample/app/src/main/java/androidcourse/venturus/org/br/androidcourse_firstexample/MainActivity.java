package androidcourse.venturus.org.br.androidcourse_firstexample;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {
    private int count = 0;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
/*
        Button button = (Button) findViewById(R.id.button_id);
        button.setOnClickListener(new View.OnClickListener(){
            public void onClick(View v){
                TextView label = (TextView) findViewById(R.id.label_id);
                count++;
                label.setText(getString(R.string.label_name, count));
                //label.setText(count + " Likes");
            }
        });
*/
    }

    public void likedAction(View view){
        TextView label = (TextView) findViewById(R.id.label_id);
        count++;
        label.setText(getString(R.string.label_name, count));
    }
}
