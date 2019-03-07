
//&НаКлиенте
//Процедура ЗагрузитьФото(Команда)
//	Оповещение = Новый ОписаниеОповещения("ЗакончилиВыбиратьФайл", ЭтотОбъект);
//	НачатьПомещениеФайла(Оповещение,,,Истина, УникальныйИдентификатор);
//КонецПроцедуры

//&НаКлиенте
//Процедура ЗакончилиВыбиратьФайл(Результат, Адрес, Файл, ДопПараметры) Экспорт
//	Если Результат Тогда
//		АдресКартинки = Адрес;
//		Модифицированность = Истина;
//	КонецЕсли; 	
//КонецПроцедуры
 


&НаКлиенте
Процедура ЗагрузитьФото(Команда)
	АдресВыбраннойКартинки = "";
	НачатьПомещениеФайла(Новый ОписаниеОповещения("ЗагрузитьФотоЗавершение", ЭтотОбъект, Новый Структура("АдресВыбраннойКартинки", АдресВыбраннойКартинки)), АдресВыбраннойКартинки,,Истина, УникальныйИдентификатор); 
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьФотоЗавершение(Результат, Адрес, ВыбранноеИмяФайла, ДополнительныеПараметры) Экспорт
	
	АдресВыбраннойКартинки = ДополнительныеПараметры.АдресВыбраннойКартинки;
	
	Если Результат Тогда
		АдресКартинки = АдресВыбраннойКартинки;
		Модифицированность = Истина;
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	  Если ЭтоАдресВременногоХранилища(АдресКартинки) Тогда
		  ТекущийОбъект.ДанныеКартинки = Новый ХранилищеЗначения(
	  					ПолучитьИзВременногоХранилища(АдресКартинки));
	  КонецЕсли; 
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	АдресКартинки = ПолучитьНавигационнуюСсылку(Объект.Ссылка, "ДанныеКартинки");
КонецПроцедуры
