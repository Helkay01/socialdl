import sys
import yt_dlp

def get_download_urls(url):
    ydl_opts = {
        'quiet': True,
        'skip_download': True,
        'format': 'best',  # get best format with audio+video
    }

    with yt_dlp.YoutubeDL(ydl_opts) as ydl:
        info_dict = ydl.extract_info(url, download=False)

        # If merged format, return one URL
        if 'url' in info_dict:
            return [info_dict['url']]
        
        # If multiple formats, return list
        urls = []
        if 'formats' in info_dict:
            for fmt in info_dict['formats']:
                if fmt.get('url'):
                    urls.append(fmt['url'])

        return urls

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("No URL provided.")
        sys.exit(1)

    url = sys.argv[1]

    try:
        media_urls = get_download_urls(url)
        for i, media_url in enumerate(media_urls[:3], 1):  # limit output to top 3
            print(f"URL {i}: {media_url}")
    except Exception as e:
        print(f"Error: {e}")
