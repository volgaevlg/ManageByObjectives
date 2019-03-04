#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Для Каждого СтрокаНабора Из ЭтотОбъект Цикл
		
		// Удаляем незначащие символы (пробелы) слева и справа для строковых параметров.
		СокрЛПЗначениеПоля(СтрокаНабора, "COMИмяИнформационнойБазыНаСервере1СПредприятия");
		СокрЛПЗначениеПоля(СтрокаНабора, "COMИмяПользователя");
		СокрЛПЗначениеПоля(СтрокаНабора, "COMИмяСервера1СПредприятия");
		СокрЛПЗначениеПоля(СтрокаНабора, "COMКаталогИнформационнойБазы");
		СокрЛПЗначениеПоля(СтрокаНабора, "FILEКаталогОбменаИнформацией");
		СокрЛПЗначениеПоля(СтрокаНабора, "FTPСоединениеПользователь");
		СокрЛПЗначениеПоля(СтрокаНабора, "FTPСоединениеПуть");
		СокрЛПЗначениеПоля(СтрокаНабора, "WSURLВебСервиса");
		СокрЛПЗначениеПоля(СтрокаНабора, "WSИмяПользователя");
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	// Обновляем кэш платформы для зачитывания актуальных настроек транспорта
	// сообщений обмена процедурой ОбменДаннымиПовтИсп.НастройкиОбменаДанными.
	ОбновитьПовторноИспользуемыеЗначения();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура СокрЛПЗначениеПоля(Запись, Знач Поле)
	
	Запись[Поле] = СокрЛП(Запись[Поле]);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли