#!/usr/local/bin/python3
#coding:utf-8

import sys
import os
import shutil
import time
import re
import requests
import json
from addict import Dict

class Api:
  index = "/index"
  reqplay = "/vod/reqplay/{0}"

baseUrl = "http://apple.fuliapps.com"
api = Api()
blacklist = ["5453"]

currentPath = os.path.abspath(__file__)
parentPath = os.path.abspath(os.path.dirname(currentPath) + os.path.sep + ".")
tempPath = os.path.join(parentPath, "temp/")
if not os.path.exists(tempPath):
    os.makedirs(tempPath)

def startParsing():
  downloadlistPath = os.path.abspath(os.path.join(tempPath, "aria2_{0}.txt".format(int(time.time()))))
  downloadInfos = {}

  response = None
  try:
    requestUrl = baseUrl + api.index
    response = requests.get(requestUrl)
    if response.status_code != 200:
      message = "接口响应码 %s" % response.status_code
      print(message)
      return
  except requests.exceptions.ConnectionError as error:
    message = error
    print(message)
    return

  responseJson = Dict(response.json())
  if responseJson.retcode != 0:
    message = "接口错误 %s %s" % (responseJson.retcode, responseJson.errmsg)
    print(message)
    return
  
  dayrows = responseJson.data.dayrows
  latestrows = responseJson.data.latestrows
  likerows = responseJson.data.likerows
  a_vodrows = responseJson.data.a_vodrows
  b_vodrows = responseJson.data.b_vodrows
  c_vodrows = responseJson.data.c_vodrows
  d_vodrows = responseJson.data.d_vodrows
  tagvodrows = responseJson.data.tagvodrows
  hotrows = responseJson.data.hotrows

  allrows = []
  allrows.extend(dayrows)
  allrows.extend(latestrows)
  allrows.extend(likerows)
  allrows.extend(a_vodrows)
  allrows.extend(b_vodrows)
  allrows.extend(c_vodrows)
  allrows.extend(d_vodrows)
  allrows.extend(tagvodrows)
  allrows.extend(hotrows)

  for vodModel in allrows:
    print("\n")
    vodid = vodModel.vodid
    title = vodModel.title
    print("[\033[1;34m %s \033[0m] %s " % (vodid, title))

    requestUrl = baseUrl + api.reqplay.format(str(vodid))
    try:
      response = requests.get(requestUrl)
      if response.status_code != 200:
        continue
      responseJson = Dict(response.json())
      if responseJson.retcode != 0:
        continue
      httpurl = responseJson.data.httpurl
      if len(httpurl) == 0:
        continue
      
      mp4url = ""
      # 模式1
      matchObj = re.search('/\d{8}/(\w+)/index.m3u8', httpurl)
      if matchObj:
        videoid = matchObj.group(1)
        mp4url = httpurl.replace("index.m3u8", "mp4/{0}.mp4".format(videoid))
      if not len(mp4url):
        # 模式2
        matchObj = re.search('/(\w+).m3u8', httpurl)
        if not matchObj:
          continue
        videoid = matchObj.group(1)
        mp4url = "https://xjxz.879935.com/{0}.mp4".format(videoid)
      print(mp4url)

      # https://newv1.xinliangfc.com/2bPQ99xKPN.m3u8"

      downloadInfos[str(vodid)] = {
        "title": title,
        "mp4url": mp4url
      }
    except requests.exceptions.ConnectionError as error:
      continue
  
  for vodid in blacklist:
    downloadInfos.pop(vodid)

  print("获取到 %s 个视频" % (len(downloadInfos)))
  with open(downloadlistPath, 'w') as downloadlistFile:
    for downloadInfo in downloadInfos.values():
      title = downloadInfo.get("title")
      mp4url = downloadInfo.get("mp4url")
      downloadlistFile.write("{0}\n  out={1}.mp4\n".format(mp4url, title))

  inputted = input("是否下载列表中所有视频 %s [输入 \033[1;34mY\033[0m/\033[1;34mN\033[0m ]" % downloadlistPath)
  if inputted != "Y" and inputted != "y":
    return
  os.chdir(tempPath)
  os.system("aria2c -i {0}".format(downloadlistPath))
  os.chdir(parentPath)

if __name__ == '__main__':
  startParsing()
