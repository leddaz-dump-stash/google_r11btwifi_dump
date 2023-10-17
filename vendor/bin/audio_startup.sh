#!/system/bin/sh

log_name="audio_startup"
calibration_command="/vendor/bin/crus_sp_cal"
calibration_file="/mnt/vendor/persist/audio.cal"
std_calibration="/data/vendor/audio/audio.cal"
encoded_calibration_data='
00000000: 0100 0000 0300 0000 4453 5031 2043 616c  ........DSP1 Cal
00000010: 6962 7261 7469 6f6e 2063 6420 4341 4c5f  ibration cd CAL_
00000020: 5200 0000 0000 0000 0000 0000 0000 0000  R...............
00000030: 0000 22fe 0300 0000 0400 0000 4453 5031  ..".........DSP1
00000040: 2043 616c 6962 7261 7469 6f6e 2063 6420   Calibration cd
00000050: 4341 4c5f 5354 4154 5553 0000 0000 0000  CAL_STATUS......
00000060: 0000 0000 0000 0001 0300 0000 0400 0000  ................
00000070: 4453 5031 2043 616c 6962 7261 7469 6f6e  DSP1 Calibration
00000080: 2063 6420 4341 4c5f 4348 4543 4b53 554d   cd CAL_CHECKSUM
00000090: 0000 0000 0000 0000 0000 22ff 0300 0000  ..........".....
000000a0: 0400 0000                                ....
'

function log_and_print() {
  # Log into logcat
  log -p i -t $log_name $1
  # Print to stdout
  echo $1
}

# If the audio calibration file does not exists and the build is a "userdebug"
# build, generate a new calibration file. This occurs on Dev3 development
# boards that did not go through a calibration routine.
if [[ -f "$calibration_file" ]]
then
  log_and_print "Calibration file found!"
  log_and_print "Enabling speaker protection..."
  # Kills the process if it takes longer then 15 seconds which only happens on
  # Dev2 devices.
  # TODO(b/191786370): remove timeout when the crus_sp_cal no longer has this
  # problem
  calibration_output=$(timeout 15 $calibration_command -a -f $calibration_file)
  log_and_print "$calibration_output"
  log_and_print "Speaker protection with factory calibration returned = ($?)"
else
  log_and_print "Calibration file not found!"
  log_and_print "Enabling speaker protection with generic calibration file..."

  # Create a temp file to dump the generic calibration binary data into
  echo "$encoded_calibration_data" | xxd -r > $std_calibration

  # Run speaker protection with generic calibration file
  calibration_output=$(timeout 15 $calibration_command -a -f $std_calibration)
  log_and_print "$calibration_output"
  log_and_print "Speaker protection with generic calibration returned = ($?)"
fi

