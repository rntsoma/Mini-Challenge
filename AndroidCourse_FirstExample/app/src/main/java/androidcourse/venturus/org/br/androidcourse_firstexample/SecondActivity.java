package androidcourse.venturus.org.br.androidcourse_firstexample;

import android.app.DownloadManager;
import android.content.Intent;
import android.net.Uri;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

public class SecondActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_second);

        Intent myIntent = this.getIntent();
        int passedInt = myIntent.getIntExtra("num_likes", 0);

        TextView label = (TextView) findViewById(R.id.label_id);
        label.setText(getString(R.string.label_name, passedInt));
    }

    public void downloadImage (View view){
        DownloadManager mDownloadManager = (DownloadManager) getSystemService(DOWNLOAD_SERVICE);
        DownloadManager.Request myRequest = new DownloadManager.Request(Uri.parse("https://goo.gl/RnPVhk"));
        myRequest.setTitle(getString(R.string.download_title));
        mDownloadManager.enqueue(myRequest);
    }
}
