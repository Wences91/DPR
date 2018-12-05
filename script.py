#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Bibliotecas
import tweepy

# Archivo de salida
salida = open('tuits.txt', 'w')

# Cuenta de Twitter de la que descargar tuits
twitter = 'CUENTA_DE TWITTER'

# Datos de acceso a la API
auth = tweepy.OAuthHandler('API key', 'API secret key')
auth.set_access_token('Access token', 'Access token secret')
main_api = tweepy.API(auth, wait_on_rate_limit=True, wait_on_rate_limit_notify=True)

# Descarga de tuits
for friendCursor in tweepy.Cursor(main_api.user_timeline, tweet_mode='extended', trim_user='false', include_rts='false', count=200, screen_name=twitter).items():
    salida.write(friendCursor._json['full_text'] + '\n')


salida.close()
