#Область ОписаниеПеременных

// Флаг подтверждения, используется при закрытии.
&НаКлиенте
Перем ПодтверждениеЗакрытияФормы;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьУсловноеОформление();
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	ПоказыватьТолькоЗагруженныеРегионы = Истина;
	ОпределитьЗагруженныеРегионы();
	
	// Автосохранение настроек
	СохраняемыеВНастройкахДанныеМодифицированы = Истина;
	
	Если ОбщегоНазначенияКлиентСервер.ЭтоМобильныйКлиент() Тогда // Временное решение для работы в мобильном клиенте, будет удалено в следующих версиях
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ГруппаКомандЗагрузкиПанель", "ГоризонтальноеПоложение", ГоризонтальноеПоложениеЭлемента.Центр);
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "СубъектыРФ", "ВариантУправленияВысотой", ВариантУправленияВысотойТаблицы.ВСтрокахТаблицы);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ОбновитьИнтерфейсПоКоличествуОчищаемых();
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	Если Элементы.ШагиОчистки.ТекущаяСтраница <> Элементы.ОжиданиеОчистки 
		Или ПодтверждениеЗакрытияФормы = Истина Тогда
		Возврат;
	КонецЕсли;
	
	Отказ = Истина;
	Если ЗавершениеРаботы Тогда
		Возврат;
	КонецЕсли;
	
	Оповещение = Новый ОписаниеОповещения("ЗакрытиеФормыЗавершение", ЭтотОбъект);
	Текст = НСтр("ru = 'Прервать очистку адресного классификатора?'");
	ПоказатьВопрос(Оповещение, Текст, РежимДиалогаВопрос.ДаНет);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура СубъектыРФВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	
	Если Поле = Элементы.СубъектыРФПредставление Тогда
		ТекущиеДанные = СубъектыРФ.НайтиПоИдентификатору(ВыбраннаяСтрока);
		Если ТекущиеДанные <> Неопределено Тогда
			ТекущиеДанные.Очищать = Не ТекущиеДанные.Очищать;
			ОбновитьИнтерфейсПоКоличествуОчищаемых();
		КонецЕсли
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СубъектыРФОчищатьПриИзменении(Элемент)
	
	ОбновитьИнтерфейсПоКоличествуОчищаемых();
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказыватьТолькоЗагруженныеРегионыПриИзменении(Элемент)
	ОпределитьЗагруженныеРегионы();
КонецПроцедуры


#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура УстановитьФлажки(Команда)
	
	УстановитьПометкиСпискаРегионов(Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура СнятьФлажки(Команда)
	
	УстановитьПометкиСпискаРегионов(Ложь);
	
КонецПроцедуры

&НаКлиенте
Процедура Очистить(Команда)
	
	ОчиститьКлассификатор();
	
КонецПроцедуры

&НаКлиенте
Процедура ПрерватьОчистку(Команда)
	
	Оповещение = Новый ОписаниеОповещения("ПослеВопросаПрерватьОчистку", ЭтотОбъект);
	
	Текст = НСтр("ru = 'Прервать очистку адресного классификатора?'");
	ПоказатьВопрос(Оповещение, Текст, РежимДиалогаВопрос.ДаНет);
	
КонецПроцедуры

&НаКлиенте
Процедура ОтметитьЗагруженные(Команда)
	Для каждого Регион Из СубъектыРФ Цикл
		Регион.Очищать = Регион.Загружено;
	КонецЦикла;
	ОбновитьИнтерфейсПоКоличествуОчищаемых();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Завершение диалога закрытия формы.
&НаКлиенте
Процедура ЗакрытиеФормыЗавершение(Знач РезультатВопроса, Знач ДополнительныеПараметры) Экспорт
	
	Если РезультатВопроса = КодВозвратаДиалога.Да Тогда
		ПодтверждениеЗакрытияФормы = Истина;
		Закрыть();
	Иначе 
		ПодтверждениеЗакрытияФормы = Неопределено;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура УстановитьРазрешениеОчистки(Знач КоличествоОчищаемых = Неопределено)
	
	Если КоличествоОчищаемых = Неопределено Тогда
		КоличествоОчищаемых = СубъектыРФ.НайтиСтроки( Новый Структура("Очищать", Истина) ).Количество();
	КонецЕсли;
	
	Элементы.Очистить.Доступность = КоличествоОчищаемых > 0
КонецПроцедуры

&НаСервере
Процедура УстановитьУсловноеОформление()
	УсловноеОформление.Элементы.Очистить();
	
	Элемент = УсловноеОформление.Элементы.Добавить();
	
	Поля = Элемент.Поля.Элементы;
	Поля.Добавить().Поле = Новый ПолеКомпоновкиДанных("СубъектыРФКодСубъектаРФ");
	Поля.Добавить().Поле = Новый ПолеКомпоновкиДанных("СубъектыРФПредставление");

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("СубъектыРФ.Загружено");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Ложь;

	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.ТекстЗапрещеннойЯчейкиЦвет);
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьПометкиСпискаРегионов(Знач Пометка)
	
	// Устанавливаем пометки только для видимых строк.
	ЭлементТаблицы = Элементы.СубъектыРФ;
	Для Каждого СтрокаРегиона Из СубъектыРФ Цикл
		Если ЭлементТаблицы.ДанныеСтроки( СтрокаРегиона.ПолучитьИдентификатор() ) <> Неопределено Тогда
			СтрокаРегиона.Очищать = Пометка;
		КонецЕсли;
	КонецЦикла;
	
	ОбновитьИнтерфейсПоКоличествуОчищаемых();
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьИнтерфейсПоКоличествуОчищаемых()
	
	// Страница выбора
	ВыбраноРегионовДляОчистки = СубъектыРФ.НайтиСтроки( Новый Структура("Очищать", Истина) ).Количество();
	
	// Страница загрузки
	ТекстОписанияОчистки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Очищаются данные выбранных регионов (%1)'"), ВыбраноРегионовДляОчистки);
	УстановитьРазрешениеОчистки(ВыбраноРегионовДляОчистки);
КонецПроцедуры

&НаКлиенте
Процедура ОчиститьКлассификатор()
	
	ОчиститьСообщения();
	
	// Переключаем режим - страницу.
	Элементы.ШагиОчистки.ТекущаяСтраница = Элементы.ОжиданиеОчистки;
	ТекстСостоянияОчистки = НСтр("ru = 'Очистка адресного классификатора ...'");
	
	Элементы.ПрерватьОчистку.Доступность = Истина;
	
	ОповещениеОПрогрессеВыполнения = Новый ОписаниеОповещения("ПрогрессВыполнения", ЭтотОбъект);
	
	Задание = ЗапуститьФоновуюОчисткуНаСервере(КодыРегионовДляОчистки(), УникальныйИдентификатор);
	ИдентификаторЗадания = Задание.ИдентификаторЗадания;
	
	НастройкиОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(ЭтотОбъект);
	НастройкиОжидания.ВыводитьОкноОжидания = Ложь;
	НастройкиОжидания.ОповещениеОПрогрессеВыполнения = ОповещениеОПрогрессеВыполнения;
	
	Обработчик = Новый ОписаниеОповещения("ПослеФоновойОчистки", ЭтотОбъект);
	ДлительныеОперацииКлиент.ОжидатьЗавершение(Задание, Обработчик, НастройкиОжидания);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеФоновойОчистки(Задание, ДополнительныеПараметры) Экспорт
	
	Если Задание = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если Задание.Статус = "Выполнено" Тогда
		Элементы.ШагиОчистки.ТекущаяСтраница = Элементы.УспешноеЗавершение;
		ТекстОписанияОчистки = НСтр("ru = 'Адресный классификатор успешно очищен.'");
		ОбновитьПовторноИспользуемыеЗначения();
		
		Оповестить("ОчищенАдресныйКлассификатор", КлассификаторСодержитЗагруженныеАдресныеСведения(), ЭтотОбъект);
		
		Элементы.Закрыть.КнопкаПоУмолчанию = Истина;
		ТекущийЭлемент = Элементы.Закрыть;
		ПодтверждениеЗакрытияФормы = Истина;
	ИначеЕсли Задание.Статус = "Ошибка" Тогда
		Элементы.ШагиОчистки.ТекущаяСтраница = Элементы.ВыборРегионовОчистки;
		ТекстОшибки = НСтр("ru = 'Не удается очистить адресный классификатор.'");
		ТекстОшибки = ТекстОшибки + Символы.ПС + НСтр("ru = 'Техническая информация:'") + Задание.ПодробноеПредставлениеОшибки;
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстОшибки);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПрогрессВыполнения(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат.Статус = "Выполняется" Тогда
		Прогресс = ПрочитатьПрогресс(Результат.ИдентификаторЗадания);
		Если Прогресс <> Неопределено Тогда
			ТекстСостоянияОчистки = Прогресс.Текст;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция КлассификаторСодержитЗагруженныеАдресныеСведения()
	
	ИспользоватьЗагруженные = АдресныйКлассификаторСлужебный.СведенияОДоступностиАдресныхСведений().Получить("ИспользоватьЗагруженные");
	Возврат ИспользоватьЗагруженные = Истина;
	
КонецФункции

&НаСервереБезКонтекста
Функция ПрочитатьПрогресс(ИдентификаторЗадания)
	Возврат ДлительныеОперации.ПрочитатьПрогресс(ИдентификаторЗадания);
КонецФункции

&НаСервереБезКонтекста
Функция ЗапуститьФоновуюОчисткуНаСервере(Знач КодыРегионов, Знач УникальныйИдентификатор)
	
	ПараметрыМетода = Новый Массив;
	ПараметрыМетода.Добавить(КодыРегионов);
	
	ПараметрыВыполнения = ДлительныеОперации.ПараметрыВыполненияВФоне(УникальныйИдентификатор);
	ПараметрыВыполнения.НаименованиеФоновогоЗадания = НСтр("ru = 'Очистка адресного классификатора'");
	
	ФоновоеЗадание = ДлительныеОперации.ВыполнитьВФоне("АдресныйКлассификаторСлужебный.ФоновоеЗаданиеОчисткиКлассификатораАдресов",
		ПараметрыМетода, ПараметрыВыполнения);
		
	Возврат ФоновоеЗадание;
КонецФункции

&НаКлиенте
Процедура ПослеВопросаПрерватьОчистку(Результат, ДополнительныеПараметры) Экспорт
	Если Результат = КодВозвратаДиалога.Да Тогда
		ОтменитьФоновоеЗадание(ИдентификаторЗадания);
		Элементы.ШагиОчистки.ТекущаяСтраница = Элементы.ВыборРегионовОчистки;
		ОпределитьЗагруженныеРегионы();
	КонецЕсли;
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ОтменитьФоновоеЗадание(Знач Идентификатор)
	
	Если Идентификатор <> Неопределено Тогда
		ДлительныеОперации.ОтменитьВыполнениеЗадания(Идентификатор);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОпределитьЗагруженныеРегионы()
	
	// Получаем уже загруженные регионы.
	ТаблицаРегионов = АдресныйКлассификаторСлужебный.СведенияОЗагрузкеСубъектовРФ();
	ТаблицаРегионов.Колонки.Добавить("Очищать", Новый ОписаниеТипов("Булево"));
	
	Для Каждого Регион Из ТаблицаРегионов Цикл
		Регион.Представление = Формат(Регион.КодСубъектаРФ, "ЧЦ=2; ЧН=; ЧВН=; ЧГ=") + ", " + Регион.Представление;
	КонецЦикла;
	
	Если ПоказыватьТолькоЗагруженныеРегионы Тогда
		Индекс = ТаблицаРегионов.Количество() - 1;
		Пока Индекс >= 0 Цикл
			СтрокаТаблицы = ТаблицаРегионов.Получить(Индекс);
			Если НЕ СтрокаТаблицы.Загружено Тогда
				ТаблицаРегионов.Удалить(СтрокаТаблицы);
			КонецЕсли;
			Индекс = Индекс - 1;
		КонецЦикла;
	КонецЕсли;
	
	ЗначениеВРеквизитФормы(ТаблицаРегионов, "СубъектыРФ");

КонецПроцедуры

&НаКлиенте
Функция КодыРегионовДляОчистки()
	Результат = Новый Массив;
	
	Для Каждого Регион Из СубъектыРФ.НайтиСтроки( Новый Структура("Очищать", Истина) ) Цикл
		Результат.Добавить(Регион.КодСубъектаРФ);
	КонецЦикла;
	
	Возврат Результат;
КонецФункции

#КонецОбласти
