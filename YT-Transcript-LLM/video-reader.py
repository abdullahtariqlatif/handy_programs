import ollama
from youtube_transcript_api import YouTubeTranscriptApi

video_id = 'uPfkSi-Yc1g'

print("Fetching transcript from YouTube...")
# Create an instance and call .fetch()
ytt_api = YouTubeTranscriptApi()
fetched = ytt_api.fetch(video_id)
transcript_list = fetched.to_raw_data()

full_text = " ".join([item['text'] for item in transcript_list])

print("Transcript fetched! Sending to Ollama (llama3.2:3b)...")

response = ollama.chat(model='llama3.2:3b', messages=[
    {'role': 'user', 'content': f'Tell me everything important in this video transcript:\n\n{full_text}'}
])

print("\n--- SUMMARY ---\n")
print(response['message']['content'])
