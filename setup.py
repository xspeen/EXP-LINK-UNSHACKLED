from setuptools import setup, find_packages

with open("README.md", "r", encoding="utf-8") as fh:
    long_description = fh.read()

with open("requirements.txt", "r", encoding="utf-8") as fh:
    requirements = fh.read().splitlines()

setup(
    name="exp-link-unshackled",
    version="3.0.0",
    author="xspeen",
    author_email="xspeen@users.noreply.github.com",
    description="UNSHACKLED Universal Media Extractor - NO LIMITS Downloads from ANY platform including private/premium content",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/xspeen/EXP-LINK-UNSHACKLED",
    project_urls={
        "Bug Tracker": "https://github.com/xspeen/EXP-LINK-UNSHACKLED/issues",
        "Source Code": "https://github.com/xspeen/EXP-LINK-UNSHACKLED",
        "Documentation": "https://github.com/xspeen/EXP-LINK-UNSHACKLED#readme",
    },
    packages=find_packages(),
    classifiers=[
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.6",
        "Programming Language :: Python :: 3.7",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: 3.10",
        "Programming Language :: Python :: 3.11",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
        "Development Status :: 5 - Production/Stable",
        "Intended Audience :: End Users/Desktop",
        "Topic :: Internet :: WWW/HTTP",
        "Topic :: Multimedia :: Video",
        "Topic :: Utilities",
        "Environment :: Console",
    ],
    python_requires=">=3.6",
    install_requires=requirements,
    entry_points={
        "console_scripts": [
            "exp-link=exp_link:main",
            "exp-link-unshackled=exp_link:main",
        ],
    },
    py_modules=["exp_link"],
    include_package_data=True,
    zip_safe=False,
    keywords="downloader, video, youtube-dl, yt-dlp, social-media, instagram, tiktok, pinterest, youtube, unshackled",
)
