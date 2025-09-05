# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    screen_saver.py                                    :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mstasiak <mstasiak@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/25 11:08:49 by mstasiak          #+#    #+#              #
#    Updated: 2025/09/05 14:26:35 by mstasiak         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

import time  # Import time module for sleep functionality
import sys  # Import sys module for system-specific parameters and functions
import subprocess  # Import subprocess module to execute system commands
import random  # Import random module to generate random numbers
import signal  # Import signal module to handle signals
import tkinter as tk  # Import tkinter module for creating GUI applications
from datetime import datetime, timedelta  # Import for time tracking

start_time = datetime.now()  # Track when the script starts
max_runtime = timedelta(hours=72)  # Set maximum runtime to 72 hours (3 days)

def handle_ctrl_h(signum, frame):
    # Handle Ctrl+H signal (SIGQUIT)
    print("\nExiting...")
    root.quit()
    sys.exit(0)

def handle_key(event):
    # Block all keyboard inputs except Ctrl+H
    if event.keysym == 'h' and event.state & 0x4:  # Ctrl+H
        root.quit()
        sys.exit(0)
    return "break"  # Block all other key events

def handle_mouse(event):
    # Block mouse clicks and scroll
    return "break"  # Prevent mouse click and scroll events from being processed

def handle_home(event):
    # Ignore Home button press
    print("\nHome")
    return "break"

def check_runtime():
    # Check if runtime exceeds 72 hours
    if datetime.now() - start_time > max_runtime:
        print("\nAuto-logout after 72 hours...")
        subprocess.run(["gnome-session-quit", "--force"])  # Force logout in Ubuntu 22
        root.quit()
        sys.exit(0)
    root.after(60000, check_runtime)  # Check every minute

# Register Ctrl+H signal handler
signal.signal(signal.SIGQUIT, handle_ctrl_h)

# Get screen dimensions
if sys.argv[1:]:
    # Use provided screen dimensions if available
    scr = [sys.argv[1], sys.argv[2]]
else:
    # Get screen dimensions using xrandr command
    xr = [s for s in subprocess.check_output("xrandr").decode("utf-8").split() if "+0+" in s]
    scr = [str(int(n)/2) for n in xr[0].split("+")[0].split("x")]

# Create window
root = tk.Tk()
root.attributes('-fullscreen', True)  # Set window to fullscreen mode
root.config(cursor="none")  # Hide cursor
text = ""

label = tk.Label(root, text=text, font=('mono', 10), fg='#909090', bg='black')  # Create label with custom text and styling
label.pack(expand=True, fill='both')  # Pack label to fill the window

def move_cursor():
    # Function to move cursor to random positions
    counter = 0
    while True:
        try:
            counter += 1
            # Generate random x,y coordinates within screen bounds
            x = random.randint(0, int(float(scr[0])))
            y = random.randint(0, int(float(scr[1])))
            
            # Move cursor to random position
            subprocess.Popen(["xdotool", "mousemove", str(x), str(y)])
            
            print(f"Iteration {counter}: Moved cursor to position {x}, {y}")
            time.sleep(55)  # Wait for 55 seconds before next move
        except KeyboardInterrupt:
            # Handle keyboard interrupt
            print("\nExiting...")
            sys.exit(0)

def prevent_sleep():
    # Prevent system from sleeping
    root.after(1000, prevent_sleep)
    root.update_idletasks()
    root.update()
    subprocess.run(["xset", "-display", ":0.0", "dpms", "force", "off"])

# Start cursor movement in a separate thread
import threading  # Import threading module to handle threads
cursor_thread = threading.Thread(target=move_cursor)  # Create a thread for cursor movement
cursor_thread.daemon = True  # Set thread as daemon
cursor_thread.start()  # Start the thread

prevent_sleep()  # Call prevent_sleep function
check_runtime()  # Start runtime checking

# Bind events to block keyboard and mouse inputs
root.bind('<Key>', handle_key)  # Block all keyboard inputs except Ctrl+H
root.bind('<Button-1>', handle_mouse)  # Block left click
root.bind('<Button-2>', handle_mouse)  # Block middle click (scroll wheel click)
root.bind('<Button-3>', handle_mouse)  # Block right click
root.bind('<MouseWheel>', handle_mouse)  # Block scroll wheel
root.bind('<Button-4>', handle_mouse)  # Block scroll up
root.bind('<Button-5>', handle_mouse)  # Block scroll down
root.bind('<Super_L>', handle_home)  # Block left Super (Windows) key
root.bind('<Super_R>', handle_home)  # Block right Super (Windows) key

root.mainloop()  # Start Tkinter event loop
