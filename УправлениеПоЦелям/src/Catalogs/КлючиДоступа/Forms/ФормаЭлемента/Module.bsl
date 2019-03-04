
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ТолькоПросмотр = Истина;
	
	РасшифровкаСоставаПолей = РасшифровкаСоставаПолей(Объект.СоставПолей);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ВключитьВозможностьРедактирования(Команда)
	
	ТолькоПросмотр = Ложь;
	
	ПоказатьПредупреждение(,
		НСтр("ru = 'Ключ доступа не следует изменять, так как он сопоставлен с разными объектами.
		           |Чтобы исправить нестандартную проблему следует удалить ключ доступа или
		           |связь с ним в регистрах и выполнить процедуру обновления доступа.'"));
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция РасшифровкаСоставаПолей(СоставПолей)
	
	ТекущееЧисло = СоставПолей;
	Расшифровка = "";
	
	НомерТабличнойЧасти = 0;
	Пока ТекущееЧисло > 0 Цикл
		Остаток = ТекущееЧисло - Цел(ТекущееЧисло / 16) * 16;
		Если НомерТабличнойЧасти = 0 Тогда
			Расшифровка = НСтр("ru = 'Шапка'") + ": " + Остаток;
		Иначе
			Расшифровка = Расшифровка + ", " + НСтр("ru = 'Табличная часть'") + " " + НомерТабличнойЧасти + ": " + Остаток;
		КонецЕсли;
		ТекущееЧисло = Цел(ТекущееЧисло / 16);
		НомерТабличнойЧасти = НомерТабличнойЧасти + 1;
	КонецЦикла;
	
	Возврат Расшифровка;
	
КонецФункции

#КонецОбласти
