#!/usr/local/bin/python

from sys import argv
import os
import math
import urllib2
import time
import random

def deg2num(lat_deg, lon_deg, zoom):
	lat_rad = math.radians(lat_deg)
	n = 2.0 ** zoom
	xtile = int((lon_deg + 180.0) / 360.0 * n)
	ytile = int((1.0 - math.log(math.tan(lat_rad) + (1 / math.cos(lat_rad))) / math.pi) / 2.0 * n)
	return (xtile, ytile)

def download_url(zoom, xtile, ytile, download_path):
	# Switch between otile1 - otile4

	subdomain = random.randint(1, 4)

	url = "http://%d.basemaps.cartocdn.com/dark_all/%d/%d/%d@2x.png" % (subdomain, zoom, xtile, ytile)
	dir_path = "%s/tiles/%d/%d/" % (download_path, zoom, xtile)
	download_path = "%s/tiles/%d/%d/%d.png" % (download_path, zoom, xtile, ytile)

	if not os.path.exists(dir_path):
		os.makedirs(dir_path)

	print "downloading %r" % url
	time.sleep(1)

	source = urllib2.urlopen(url)
	content = source.read()
	source.close()
	destination = open(download_path,'wb')
	destination.write(content)
	destination.close()

def main(argv):
	try:
		south = 52.0
		west = 20.7
		north = 52.4
		east = 21.3
		min_zoom = 14
		max_zoom = 14
		download_path = "./www/"
	except:
		exit(2)

	for zoom in range(int(min_zoom), int(max_zoom) + 1, 1):
		xtile, ytile = deg2num(float(south), float(west), float(zoom))
		final_xtile, final_ytile = deg2num(float(north), float(east), float(zoom))

		for x in range(xtile, final_xtile + 1, 1):
			for y in range(ytile, final_ytile - 1, -1):
				download_url(int(zoom), x, y, download_path)
	return 0

main(argv)
