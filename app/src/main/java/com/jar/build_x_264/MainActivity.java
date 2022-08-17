package com.jar.build_x_264;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.widget.TextView;

import com.jar.build_x_264.databinding.ActivityMainBinding;

public class MainActivity extends AppCompatActivity {

    // Used to load the 'build_x_264' library on application startup.
    static {
        System.loadLibrary("build_x_264");
    }

    private ActivityMainBinding binding;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        binding = ActivityMainBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        // Example of a call to a native method
        TextView tv = binding.sampleText;
        tv.setText(stringFromJNI());
    }

    /**
     * A native method that is implemented by the 'build_x_264' native library,
     * which is packaged with this application.
     */
    public native String stringFromJNI();
}