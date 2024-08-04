import time
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
import hashlib
import gptapi  # Import the gptapi module instead of running it as a separate script
import threading

result_data = {"result": None}

class WatchdogHandler(FileSystemEventHandler):
    def __init__(self, file_path, result_data):
        self.file_path = file_path
        self.result_data = result_data
        self.last_hash = self.hash_file()

    def hash_file(self):
        """Generate MD5 hash of the file contents."""
        hasher = hashlib.md5()
        try:
            with open(self.file_path, 'rb') as f:
                buf = f.read()
                hasher.update(buf)
        except FileNotFoundError:
            return None
        return hasher.hexdigest()

    def on_modified(self, event):
        if event.src_path.endswith(self.file_path):
            current_hash = self.hash_file()
            if current_hash != self.last_hash:
                self.last_hash = current_hash
                result = gptapi.main()
                self.result_data["result"] = result

def start_observer(result_data):
    file_to_watch = 'input.txt'
    event_handler = WatchdogHandler(file_to_watch, result_data)
    observer = Observer()
    observer.schedule(event_handler, path='.', recursive=False)
    observer.start()

    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()

def run_observer_in_thread(result_data):
    observer_thread = threading.Thread(target=start_observer, args=(result_data,))
    observer_thread.daemon = True
    observer_thread.start()
