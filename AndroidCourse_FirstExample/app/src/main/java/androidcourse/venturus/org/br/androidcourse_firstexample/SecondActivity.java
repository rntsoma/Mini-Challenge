package androidcourse.venturus.org.br.androidcourse_firstexample;

import android.app.DownloadManager;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.support.v4.app.ActivityCompat;
import android.support.v4.content.ContextCompat;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.internal.view.menu.MenuDialogHelper;
import android.util.Log;
import android.view.View;
import android.widget.TextView;

import java.util.jar.Manifest;

public class SecondActivity extends AppCompatActivity {
    private static  final int MY_PERMISSION_REQUEST_WRITE_STORAGE = 100;
    private long downloadID;

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
        if (ContextCompat.checkSelfPermission(this, android.Manifest.permission.WRITE_EXTERNAL_STORAGE) == PackageManager.PERMISSION_GRANTED){
            doDownload();
        }else {
            if (ActivityCompat.shouldShowRequestPermissionRationale(this, android.Manifest.permission.WRITE_EXTERNAL_STORAGE)) {
                Log.d("debug", "I need this stuff");
            }
            ActivityCompat.requestPermissions(this,
                    new String[]{android.Manifest.permission.WRITE_EXTERNAL_STORAGE},
                    MY_PERMISSION_REQUEST_WRITE_STORAGE);
        }
    }

    private void doDownload(){
        DownloadManager mDownloadManager = (DownloadManager) getSystemService(DOWNLOAD_SERVICE);
        DownloadManager.Request myRequest = new DownloadManager.Request(Uri.parse("https://goo.gl/RnPVhk"));
        myRequest.setTitle(getString(R.string.download_title));
        downloadID = mDownloadManager.enqueue(myRequest);
        registerReceiver(new DownloadCompletedReceiver(downloadID), new IntentFilter(DownloadManager.ACTION_DOWNLOAD_COMPLETE));
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        switch (requestCode){
            case MY_PERMISSION_REQUEST_WRITE_STORAGE:
                if(grantResults.length > 0 && grantResults[0]==PackageManager.PERMISSION_GRANTED){
                    doDownload();
                }
                else{
                    Log.d("debug", "permission not granted");
                }
        }
    }
}
