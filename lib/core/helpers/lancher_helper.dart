import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../generated/locale_keys.g.dart';


class LauncherHelper {
  static void launchURL({required String url}) async {
    if (!url.toString().startsWith("https")) {
      url = "https://$url";
    }
    await launchUrl(Uri.parse(url));
  }

  static void launchWhatsApp(String phone) async {
    String message = 'مرحبا بك';
    if (phone.startsWith("00966")) {
      phone = phone.substring(5);
    }
    final whatsAppNativeApp = Platform.isIOS
        ? "https://wa.me/$phone?text=$message"
        : "whatsapp://send?phone=$phone&text=$message";
    debugPrint(whatsAppNativeApp);
    if (await canLaunchUrl(Uri.parse(whatsAppNativeApp))) {
      await launchUrl(Uri.parse(whatsAppNativeApp));
    } else {
      throw LocaleKeys.exception_error.tr();
    }
  }

  static void launchYoutube({required String url}) async {
    final Uri parsedUrl = Uri.parse(url);
    if (Platform.isIOS) {
      if (await canLaunchUrl(parsedUrl)) {
        await launchUrl(parsedUrl);
      } else {
        if (await canLaunchUrl(parsedUrl)) {
          await launchUrl(parsedUrl);
        } else {
          throw 'Could not launch $parsedUrl';
        }
      }
    } else {
      if (await canLaunchUrl(parsedUrl)) {
        await launchUrl(parsedUrl);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  static Future<void> launchTwitter(String userName) async {
    final twitterProfileUrl =
        Uri.parse('twitter://user?screen_name=$userName'); // Twitter app URL
    final Uri webUrl = Uri.parse('https://twitter.com/$userName'); // Web URL
    try {
      if (await canLaunchUrl(twitterProfileUrl)) {
        await launchUrl(twitterProfileUrl);
      } else {
        if (await canLaunchUrl(webUrl)) {
          await launchUrl(webUrl);
        } else {
          throw 'Could not launch Twitter in a web browser';
        }
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  static Future<void> launchInstagram(String userName) async {
    final Uri instagramProfileUrl = Uri.parse(
        'https://www.instagram.com/$userName'); // Replace with your Instagram profile URL
    final Uri instagramNativeApp =
        Uri.parse('instagram://user?username=$userName');

    try {
      if (await canLaunchUrl(instagramNativeApp)) {
        await launchUrl(instagramNativeApp); // Open Instagram app
      } else {
        if (await canLaunchUrl(instagramProfileUrl)) {
          await launchUrl(instagramProfileUrl);
        } else {
          throw 'Could not launch Instagram in a web browser';
        }
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  static void launchFacebook(String userName) async {
    final Uri nativeUrl = Uri.parse(
        'fb://facewebmodal/f?href=https://www.facebook.com/$userName');
    final Uri webUrl = Uri.parse('https://www.facebook.com/$userName');
    if (await canLaunchUrl(nativeUrl)) {
      await launchUrl(nativeUrl);
    } else {
      if (await canLaunchUrl(webUrl)) {
        await launchUrl(
          webUrl,
        );
      } else {
        throw 'Could not launch $webUrl';
      }
    }
  }

  static Future<void> launchSnapchat(String userName) async {
    final snapchatProfileUrl =
        Uri.parse('https://www.snapchat.com/add/$userName');
    final snapChatNativeApp = Uri.parse('snapchat://add/$userName');

    try {
      if (await canLaunchUrl(snapChatNativeApp)) {
        await launchUrl(snapChatNativeApp);
      } else {
        if (await canLaunchUrl(snapchatProfileUrl)) {
          await launchUrl(snapchatProfileUrl);
        } else {
          throw 'Could not launch Snapchat in a web browser';
        }
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  static Future<void> launchTikTok(String userName) async {
    final tiktokProfileUrl = Uri.parse('https://www.tiktok.com/@$userName');

    try {
      if (await canLaunchUrl(Uri.parse('com.zhiliaoapp.musically'))) {
        await launchUrl(
            Uri.parse('com.zhiliaoapp.musically://user?u=$userName'));
      } else {
        if (await canLaunchUrl(tiktokProfileUrl)) {
          await launchUrl(tiktokProfileUrl);
        } else {
          throw 'Could not launch TikTok in a web browser';
        }
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  static void callPhone({phone}) async {
    await launchUrl(Uri.parse('tel:$phone'));
  }

  static void sendMail(mail) async {
    await launchUrl(Uri.parse('mailto:$mail'));
  }

  static Future<void> launchGoogleMap(LatLng latLng) async {
    final Uri googleMapsUri = Uri.parse('https://www.google.com/maps/search/?api=1&query=${latLng.latitude},${latLng.longitude}');
    if (await canLaunchUrl(googleMapsUri)) {
      await launchUrl(googleMapsUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $googleMapsUri';
    }
  }

  static Future<void> launchMapToViewProviders(List<LatLng> locations)async{
    String googleMapsUrl = "https://www.google.com/maps/dir/";

    for (LatLng location in locations) {
      googleMapsUrl += "${location.latitude},${location.longitude}/";
    }

    Uri uri = Uri.parse(googleMapsUrl);

    if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch Google Maps";
    }
  }
}
