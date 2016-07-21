package androidcourse.venturus.org.br.androidcourse_firstexample;

import android.app.DownloadManager;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.widget.Toast;

public class DownloadCompletedReceiver extends BroadcastReceiver {
    private long mDownloadId = -1;

    public DownloadCompletedReceiver(long downloadId) {
        mDownloadId = downloadId;
    }

    @Override
    public void onReceive(Context context, Intent intent) {
        String action = intent.getAction();
        if(DownloadManager.ACTION_DOWNLOAD_COMPLETE.equals(action)){
            long downloadId = intent.getLongExtra(DownloadManager.EXTRA_DOWNLOAD_ID, 0);
            if(downloadId == mDownloadId){
                Toast toast = Toast.makeText(context, R.string.download_completed_text, Toast.LENGTH_LONG);
                toast.show();
            }
        }
    }
}
