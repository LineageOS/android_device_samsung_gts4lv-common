/*
 * Copyright (c) 2019 The LineageOS Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.lineageos.audiorotationmonitor;

import android.content.Context;
import android.hardware.display.DisplayManager;
import android.os.Handler;
import android.os.SystemProperties;
import android.util.Log;
import android.view.Surface;
import android.view.WindowManager;

public class DisplayListener implements DisplayManager.DisplayListener {
    private static final boolean DEBUG = true;
    private static final String TAG = "DisplayListener";

    private static final String AUDIO_ROTATION_PROP = "sys.audio.rotation";

    private Context mContext;
    private Handler mHandler;

    private DisplayManager mDisplayManager;
    private WindowManager mWindowManager;

    private final Object mRotationLock = new Object();
    private int mDeviceRotation = Surface.ROTATION_0;

    public DisplayListener(Context context) {
        mContext = context;
        mHandler = new Handler();

        mDisplayManager = mContext.getSystemService(DisplayManager.class);
        mWindowManager = mContext.getSystemService(WindowManager.class);
    }

    @Override
    public void onDisplayAdded(int displayId) {
        if (DEBUG) Log.d(TAG, "onDisplayAdded");
    }

    @Override
    public void onDisplayRemoved(int displayId) {
        if (DEBUG) Log.d(TAG, "onDisplayRemoved");
    }

    @Override
    public void onDisplayChanged(int displayId) {
        if (DEBUG) Log.d(TAG, "onDisplayChanged");
        updateOrientation();
    }

    private void updateOrientation() {
        // Even though we're responding to device orientation events,
        // use display rotation so audio stays in sync with video/dialogs
        int newRotation = mWindowManager.getDefaultDisplay().getRotation();

        synchronized (mRotationLock) {
            if (newRotation != mDeviceRotation) {
                mDeviceRotation = newRotation;
                SystemProperties.set(AUDIO_ROTATION_PROP, String.valueOf(mDeviceRotation));
            }
        }
    }

    public void enable() {
        if (DEBUG) Log.d(TAG, "Enabling");
        mDisplayManager.registerDisplayListener(this, mHandler);
        updateOrientation();
    }

    public void disable() {
        if (DEBUG) Log.d(TAG, "Disabling");
        mDisplayManager.unregisterDisplayListener(this);
    }
}
