#! /vendor/bin/sh

# Copyright (c) 2012-2013, 2016-2018, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
# notice, this list of conditions and the following disclaimer in the
# documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
# the names of its contributors may be used to endorse or promote
# products derived from this software without specific prior written
# permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

# Apply settings for sdm710
# Set the default IRQ affinity to the silver cluster. When a
# CPU is isolated/hotplugged, the IRQ affinity is adjusted
# to one of the CPU from the default IRQ affinity mask.
echo 3f > /proc/irq/default_smp_affinity

# Core control parameters on silver
echo 0 0 0 0 1 1 > /sys/devices/system/cpu/cpu0/core_ctl/not_preferred
echo 4 > /sys/devices/system/cpu/cpu0/core_ctl/min_cpus
echo 60 > /sys/devices/system/cpu/cpu0/core_ctl/busy_up_thres
echo 40 > /sys/devices/system/cpu/cpu0/core_ctl/busy_down_thres
echo 100 > /sys/devices/system/cpu/cpu0/core_ctl/offline_delay_ms
echo 0 > /sys/devices/system/cpu/cpu0/core_ctl/is_big_cluster
echo 8 > /sys/devices/system/cpu/cpu0/core_ctl/task_thres

# Setting b.L scheduler parameters
echo 96 > /proc/sys/kernel/sched_upmigrate
echo 90 > /proc/sys/kernel/sched_downmigrate
echo 140 > /proc/sys/kernel/sched_group_upmigrate
echo 120 > /proc/sys/kernel/sched_group_downmigrate
echo 1 > /proc/sys/kernel/sched_walt_rotate_big_tasks

# configure governor settings for little cluster
echo "schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/rate_limit_us
echo 1209600 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
echo 576000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq

# configure governor settings for big cluster
echo "schedutil" > /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
echo 0 > /sys/devices/system/cpu/cpu6/cpufreq/schedutil/rate_limit_us
echo 1344000 > /sys/devices/system/cpu/cpu6/cpufreq/schedutil/hispeed_freq
echo 652800 > /sys/devices/system/cpu/cpu6/cpufreq/scaling_min_freq

# sched_load_boost as -6 is equivalent to target load as 85. It is per cpu tunable.
echo -6 >  /sys/devices/system/cpu/cpu6/sched_load_boost
echo -6 >  /sys/devices/system/cpu/cpu7/sched_load_boost
echo 85 > /sys/devices/system/cpu/cpu6/cpufreq/schedutil/hispeed_load

echo "0:1209600" > /sys/module/cpu_boost/parameters/input_boost_freq
echo 40 > /sys/module/cpu_boost/parameters/input_boost_ms

# change DDR, L3, LLC node permission
chown system.system /sys/class/devfreq/soc:qcom,l3-cpu0/available_frequencies
chown system.system /sys/class/devfreq/soc:qcom,l3-cpu0/min_freq
chown system.system /sys/class/devfreq/soc:qcom,l3-cpu0/max_freq
chown system.system /sys/class/devfreq/soc:qcom,l3-cpu6/available_frequencies
chown system.system /sys/class/devfreq/soc:qcom,l3-cpu6/min_freq
chown system.system /sys/class/devfreq/soc:qcom,l3-cpu6/max_freq
chown system.system /sys/class/devfreq/soc:qcom,memlat-cpu0/available_frequencies
chown system.system /sys/class/devfreq/soc:qcom,memlat-cpu0/min_freq
chown system.system /sys/class/devfreq/soc:qcom,memlat-cpu0/max_freq
chown system.system /sys/class/devfreq/soc:qcom,memlat-cpu6/available_frequencies
chown system.system /sys/class/devfreq/soc:qcom,memlat-cpu6/min_freq
chown system.system /sys/class/devfreq/soc:qcom,memlat-cpu6/max_freq
chown system.system /sys/class/devfreq/soc:qcom,llccbw/available_frequencies
chown system.system /sys/class/devfreq/soc:qcom,llccbw/min_freq
chown system.system /sys/class/devfreq/soc:qcom,llccbw/max_freq
chown system.system /sys/class/devfreq/soc:qcom,mincpubw/available_frequencies
chown system.system /sys/class/devfreq/soc:qcom,mincpubw/min_freq
chown system.system /sys/class/devfreq/soc:qcom,mincpubw/max_freq
chmod 664 /sys/class/devfreq/soc:qcom,l3-cpu0/min_freq
chmod 664 /sys/class/devfreq/soc:qcom,l3-cpu0/max_freq
chmod 664 /sys/class/devfreq/soc:qcom,l3-cpu6/min_freq
chmod 664 /sys/class/devfreq/soc:qcom,l3-cpu6/max_freq
chmod 664 /sys/class/devfreq/soc:qcom,memlat-cpu0/min_freq
chmod 664 /sys/class/devfreq/soc:qcom,memlat-cpu0/max_freq
chmod 664 /sys/class/devfreq/soc:qcom,memlat-cpu6/min_freq
chmod 664 /sys/class/devfreq/soc:qcom,memlat-cpu6/max_freq
chmod 664 /sys/class/devfreq/soc:qcom,llccbw/min_freq
chmod 664 /sys/class/devfreq/soc:qcom,llccbw/max_freq
chmod 664 /sys/class/devfreq/soc:qcom,mincpubw/min_freq
chmod 664 /sys/class/devfreq/soc:qcom,mincpubw/max_freq
	  
# change schedUtil governor node permission
chown system.system /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
chown system.system /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_load
chown system.system /sys/devices/system/cpu/cpu0/cpufreq/schedutil/pl
chown system.system /sys/devices/system/cpu/cpu6/cpufreq/schedutil/hispeed_freq
chown system.system /sys/devices/system/cpu/cpu6/cpufreq/schedutil/hispeed_load
chown system.system /sys/devices/system/cpu/cpu6/cpufreq/schedutil/pl
chmod 664 /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
chmod 664 /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_load
chmod 664 /sys/devices/system/cpu/cpu0/cpufreq/schedutil/pl
chmod 664 /sys/devices/system/cpu/cpu6/cpufreq/schedutil/hispeed_freq
chmod 664 /sys/devices/system/cpu/cpu6/cpufreq/schedutil/hispeed_load
chmod 664 /sys/devices/system/cpu/cpu6/cpufreq/schedutil/pl
	  
# Enable bus-dcvs
for cpubw in /sys/class/devfreq/*qcom,cpubw*
    do
        echo "bw_hwmon" > $cpubw/governor
        echo 50 > $cpubw/polling_interval
        echo "1144 1720 2086 2929 3879 5931 6881" > $cpubw/bw_hwmon/mbps_zones
        echo 4 > $cpubw/bw_hwmon/sample_ms
        echo 68 > $cpubw/bw_hwmon/io_percent
        echo 20 > $cpubw/bw_hwmon/hist_memory
        echo 0 > $cpubw/bw_hwmon/hyst_length
        echo 80 > $cpubw/bw_hwmon/down_thres
        echo 0 > $cpubw/bw_hwmon/guard_band_mbps
        echo 250 > $cpubw/bw_hwmon/up_scale
        echo 1600 > $cpubw/bw_hwmon/idle_mbps
    done

#Enable mem_latency governor for DDR scaling
for memlat in /sys/class/devfreq/*qcom,memlat-cpu*
    do
        echo "mem_latency" > $memlat/governor
        echo 10 > $memlat/polling_interval
        echo 400 > $memlat/mem_latency/ratio_ceil
    done

#Enable mem_latency governor for L3 scaling
for memlat in /sys/class/devfreq/*qcom,l3-cpu*
    do
        echo "mem_latency" > $memlat/governor
        echo 10 > $memlat/polling_interval
        echo 400 > $memlat/mem_latency/ratio_ceil
    done

#Enable userspace governor for L3 cdsp nodes
for l3cdsp in /sys/class/devfreq/*qcom,l3-cdsp*
    do
        echo "userspace" > $l3cdsp/governor
        chown -h system $l3cdsp/userspace/set_freq
    done

echo "cpufreq" > /sys/class/devfreq/soc:qcom,mincpubw/governor

# Disable CPU Retention
echo N > /sys/module/lpm_levels/L3/cpu0/ret/idle_enabled
echo N > /sys/module/lpm_levels/L3/cpu1/ret/idle_enabled
echo N > /sys/module/lpm_levels/L3/cpu2/ret/idle_enabled
echo N > /sys/module/lpm_levels/L3/cpu3/ret/idle_enabled
echo N > /sys/module/lpm_levels/L3/cpu4/ret/idle_enabled
echo N > /sys/module/lpm_levels/L3/cpu5/ret/idle_enabled
echo N > /sys/module/lpm_levels/L3/cpu6/ret/idle_enabled
echo N > /sys/module/lpm_levels/L3/cpu7/ret/idle_enabled

# cpuset parameters
echo 0-5 > /dev/cpuset/background/cpus
echo 0-5 > /dev/cpuset/system-background/cpus

# Turn off scheduler boost at the end
echo 0 > /proc/sys/kernel/sched_boost

# Turn on sleep modes.
echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled

# Change power debug parameters permission
chown radio.system /sys/module/qpnp_power_on/parameters/reset_enabled
chown radio.system /sys/module/qpnp_power_on/parameters/wake_enabled
chown radio.system /sys/module/lpm_levels/parameters/secdebug
chmod 664 /sys/module/qpnp_power_on/parameters/reset_enabled
chmod 664 /sys/module/qpnp_power_on/parameters/wake_enabled
chmod 664 /sys/module/lpm_levels/parameters/secdebug
chown radio.system /sys/power/volkey_wakeup
chmod 0660 /sys/power/volkey_wakeup

# Volume down key(connect to PMIC RESIN) wakeup enable/disable
echo 0 > /sys/power/volkey_wakeup

chown -h system /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
chown -h system /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor
chown -h system /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy

# Post-setup services
setprop vendor.post_boot.parsed 1

# Let kernel know our image version/variant/crm_version
if [ -f /sys/devices/soc0/select_image ]; then
    image_version="10:"
    image_version+=`getprop ro.build.id`
    image_version+=":"
    image_version+=`getprop ro.build.version.incremental`
    image_variant=`getprop ro.product.name`
    image_variant+="-"
    image_variant+=`getprop ro.build.type`
    oem_version=`getprop ro.build.version.codename`
    echo 10 > /sys/devices/soc0/select_image
    echo $image_version > /sys/devices/soc0/image_version
    echo $image_variant > /sys/devices/soc0/image_variant
    echo $oem_version > /sys/devices/soc0/image_crm_version
fi
