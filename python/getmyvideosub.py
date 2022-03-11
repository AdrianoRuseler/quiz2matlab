from pytube import YouTube
from youtube_transcript_api import YouTubeTranscriptApi
from youtube_transcript_api.formatters import JSONFormatter

video_id =  "PGp1dzQKt5U"

video_url = 'https://youtu.be/' + video_id
yt = YouTube(video_url)
# this method will download the highest resolution that video is available
yt_video = yt.streams.get_highest_resolution()

print('Downloading ...')
yt_video.download()
print('Your video is downloaded successfully')

transcript = YouTubeTranscriptApi.get_transcript(video_id,languages=['pt'])
formatter = JSONFormatter()
# .format_transcript(transcript) turns the transcript into a JSON string.
json_formatted = formatter.format_transcript(transcript)  
  
# Now we can write it out to a file.
jsonname = yt.title + '.json'
with open(jsonname, 'w', encoding='utf-8') as json_file:
    json_file.write(json_formatted)
