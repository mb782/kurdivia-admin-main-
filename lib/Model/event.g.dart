// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventData _$EventDataFromJson(Map<String, dynamic> json) => EventData(

  title:json['title'] as String,
  description: json['description'] as String,
  date: json['date'] as Timestamp,
  link: json['link'] as String,
  price: json['price'] as String, opprice: json['opprice'] as String,




);

Map<String, dynamic> _$EventDataToJson(EventData instance) => <String, dynamic>{

  'title': instance.title,
  'description': instance.description,
  'date': instance.date,
  'link': instance.link,
  'price' : instance.price,
  'opprice' : instance.opprice,



};
