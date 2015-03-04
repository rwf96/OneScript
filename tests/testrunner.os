﻿//////////////////////////////////////////////////////////////////
// 
// Объект-помощник для приемочного и юнит-тестирования
//
//////////////////////////////////////////////////////////////////

Перем Пути;
Перем КомандаЗапуска;
Перем НаборТестов;
Перем РезультатТестирования;

Перем ПутьЛогФайлаJUnit;

Перем НомерТестаДляЗапуска;
Перем НаименованиеТестаДляЗапуска;

Перем Рефлектор;

Перем ЗначенияСостоянияТестов;
Перем СтруктураПараметровЗапуска;

Перем	НаборОшибок;
Перем	НаборНереализованныхТестов;

Перем	ВсегоТестов;
Перем	ВыводитьОшибкиПодробно;

Перем ВременныеФайлы;

//////////////////////////////////////////////////////////////////////////////
// Программный интерфейс
//

Процедура ПодробныеОписанияОшибок(Знач ВключитьПодробноеОписание) Экспорт
	ВыводитьОшибкиПодробно = ВключитьПодробноеОписание;
КонецПроцедуры

//{ МЕТОДЫ ДЛЯ ПРОВЕРКИ ЗНАЧЕНИЙ (assertions). 

Процедура Проверить(Условие, ДопСообщениеОшибки = "") Экспорт
	Если Не Условие Тогда
		СообщениеОшибки = "Переданный параметр ("+Формат(Условие, "БЛ=ложь; БИ=истина")+") не является Истиной, а хотели, чтобы являлся." + ФорматДСО(ДопСообщениеОшибки);
		ВызватьИсключение(СообщениеОшибки);
	КонецЕсли;
КонецПроцедуры

Процедура ПроверитьИстину(Условие, ДопСообщениеОшибки = "") Экспорт
	Проверить(Условие, ДопСообщениеОшибки);
КонецПроцедуры

Процедура ПроверитьЛожь(Условие, ДопСообщениеОшибки = "") Экспорт
	Если Условие Тогда
		СообщениеОшибки = "Переданный параметр ("+Формат(Условие, "БЛ=ложь; БИ=истина")+") не является Ложью, а хотели, чтобы являлся." + ФорматДСО(ДопСообщениеОшибки);
		ВызватьИсключение(СообщениеОшибки);
	КонецЕсли;
КонецПроцедуры

Процедура ПроверитьДату(_Дата, _Период, ДопСообщениеОшибки = "") Экспорт
	Если _Дата < _Период.ДатаНачала или _Дата > _Период.ДатаОкончания Тогда
		представление = ПредставлениеПериода(_Период.ДатаНачала, _Период.ДатаОкончания, "ФП = Истина");
		СообщениеОшибки = "Переданный параметр ("+Формат(_Дата, "ДФ='dd.MM.yyyy HH:mm:ss'")+") не входит в период "+представление+", а хотели, чтобы являлся." + ФорматДСО(ДопСообщениеОшибки);
		ВызватьИсключение(СообщениеОшибки);
	КонецЕсли;
КонецПроцедуры

Процедура ПроверитьРавенство(ПервоеЗначение, ВтороеЗначение, ДопСообщениеОшибки = "") Экспорт
	Если ПервоеЗначение <> ВтороеЗначение Тогда
		СообщениеОшибки = "Сравниваемые значения ("+ПервоеЗначение+"; "+ВтороеЗначение+") не равны, а хотели, чтобы были равны." + ФорматДСО(ДопСообщениеОшибки);
		ВызватьИсключение(СообщениеОшибки);
	КонецЕсли;
КонецПроцедуры

Процедура ПроверитьНеРавенство(ПервоеЗначение, ВтороеЗначение, ДопСообщениеОшибки = "") Экспорт
	Если ПервоеЗначение = ВтороеЗначение Тогда
		СообщениеОшибки = "Сравниваемые значения ("+ПервоеЗначение+"; "+ВтороеЗначение+") равны, а хотели, чтобы были не равны." + ФорматДСО(ДопСообщениеОшибки);
		ВызватьИсключение(СообщениеОшибки);
	КонецЕсли;
КонецПроцедуры

Процедура ПроверитьБольше(_Больше, _Меньше, ДопСообщениеОшибки = "") Экспорт
	Если _Больше <= _Меньше Тогда
		СообщениеОшибки = "Первый параметр ("+_Больше+") меньше или равен второму ("+_Меньше+") а хотели, чтобы был больше." + ФорматДСО(ДопСообщениеОшибки);
		ВызватьИсключение(СообщениеОшибки);
	КонецЕсли;
КонецПроцедуры

Процедура ПроверитьБольшеИлиРавно(_Больше, _Меньше, ДопСообщениеОшибки = "") Экспорт
	Если _Больше < _Меньше Тогда
		СообщениеОшибки = "Первый параметр ("+_Больше+") меньше второго ("+_Меньше+") а хотели, чтобы был больше или равен." + ФорматДСО(ДопСообщениеОшибки);
		ВызватьИсключение(СообщениеОшибки);
	КонецЕсли;
КонецПроцедуры

Процедура ПроверитьМеньше(проверяемоеЗначение1, проверяемоеЗначение2, СообщениеОбОшибке = "") Экспорт
	Если проверяемоеЗначение1 >= проверяемоеЗначение2 Тогда
		ВызватьИсключение "Значение <"+проверяемоеЗначение1+"> больше или равно, чем <"+проверяемоеЗначение2+">, а ожидалось меньше"+
				ФорматДСО(СообщениеОбОшибке);
	КонецЕсли; 
КонецПроцедуры

Процедура ПроверитьМеньшеИлиРавно(проверяемоеЗначение1, проверяемоеЗначение2, СообщениеОбОшибке = "") Экспорт
	Если проверяемоеЗначение1 > проверяемоеЗначение2 Тогда
		ВызватьИсключение "Значение <"+проверяемоеЗначение1+"> больше, чем <"+проверяемоеЗначение2+">, а ожидалось меньше или равно"+
				ФорматДСО(СообщениеОбОшибке);
	КонецЕсли; 
КонецПроцедуры

// проверка идет через ЗначениеЗаполнено, но мутабельные значение всегда считаем заполненными
Процедура ПроверитьЗаполненность(ПроверяемоеЗначение, ДопСообщениеОшибки = "") Экспорт
    Попытка
        фЗаполнено = ЗначениеЗаполнено(ПроверяемоеЗначение);
    Исключение
        Возврат;
    КонецПопытки; 
    Если НЕ фЗаполнено Тогда
        ВызватьИсключение "Значение ("+ПроверяемоеЗначение+") не заполнено, а ожидалась заполненность" + ФорматДСО(ДопСообщениеОшибки);
    КонецЕсли; 
КонецПроцедуры

Процедура ПроверитьНеЗаполненность(ПроверяемоеЗначение, ДопСообщениеОшибки = "") Экспорт
	СообщениеОшибки = "Значение ("+ПроверяемоеЗначение+") заполнено, а ожидалась незаполненность" + ФорматДСО(ДопСообщениеОшибки);
	Попытка
        фЗаполнено = ЗначениеЗаполнено(ПроверяемоеЗначение);
    Исключение
        ВызватьИсключение СообщениеОшибки;
    КонецПопытки; 
    Если фЗаполнено Тогда
        ВызватьИсключение СообщениеОшибки;
    КонецЕсли; 
КонецПроцедуры

Процедура ПроверитьВхождение(строка, подстрокаПоиска, ДопСообщениеОшибки = "") Экспорт
	Если Найти(строка, подстрокаПоиска) = 0 Тогда
		СообщениеОшибки = "Искали в <"+строка+"> подстроку <"+подстрокаПоиска+">, но не нашли." + ФорматДСО(ДопСообщениеОшибки);
		ВызватьИсключение(СообщениеОшибки);
	КонецЕсли;
КонецПроцедуры

//}

// { временные файлы
Функция ИмяВременногоФайла() Экспорт
	Если ВременныеФайлы = Неопределено Тогда
		ВременныеФайлы = Новый Массив;
	КонецЕсли;
	
	ИмяВремФайла = ПолучитьИмяВременногоФайла();
	ВременныеФайлы.Добавить(ИмяВремФайла);
	
	Возврат ИмяВремФайла;
КонецФункции

Процедура УдалитьВременныеФайлы() Экспорт

	Если ВременныеФайлы <> Неопределено Тогда
		Для Каждого ИмяФайла Из ВременныеФайлы Цикл
			Попытка
				УдалитьФайлы(ИмяФайла);
			Исключение
				Сообщить("Не удален временный файл: " + ИмяФайла + "
				|-" + ОписаниеОшибки());
			КонецПопытки;
		КонецЦикла;
		
		ВременныеФайлы.Очистить();
		
	КонецЕсли;
	
КонецПроцедуры
// }

//{ Выполнение тестов - экспортные методы

Процедура ВыполнитьТесты(МассивПараметров) Экспорт
	Инициализация();
	РезультатТестирования = ЗначенияСостоянияТестов.НеВыполнялся;
	
	Если Не ОбработатьПараметрыЗапуска(МассивПараметров) Тогда
		РезультатТестирования = ЗначенияСостоянияТестов.НеВыполнялся;
	КонецЕсли; 
	УдалитьВременныеФайлы();
КонецПроцедуры 

Функция ПолучитьРезультатТестирования() Экспорт
	Возврат РезультатТестирования;
КонецФункции

//}

Функция ПолучитьПараметрыЗапуска(МассивПараметров) Экспорт
	Перем ПутьЛогФайла;
	
	Если МассивПараметров.Количество() = 0 Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	НомерТестаДляЗапуска = Неопределено;
	НаименованиеТестаДляЗапуска = Неопределено;
	ПутьЛогФайла = Неопределено;
	
	НомерПараметраПутьКТестам = -1;
	
	КомандаЗапуска = НРег(МассивПараметров[0]);
	Если КомандаЗапуска = СтруктураПараметровЗапуска.ПоказатьСписок Тогда
		путьКТестам = МассивПараметров[1];
	ИначеЕсли КомандаЗапуска = СтруктураПараметровЗапуска.Запустить Тогда
		НомерПараметраПутьКТестам = 1;
	ИначеЕсли КомандаЗапуска = СтруктураПараметровЗапуска.ЗапуститьКаталог Тогда
		НомерПараметраПутьКТестам = 1;
		
	Иначе
		КомандаЗапуска = СтруктураПараметровЗапуска.Запустить;
		НомерПараметраПутьКТестам = 0;
	КонецЕсли;

	НомерОчередногоПараметра = НомерПараметраПутьКТестам;
	
	Если КомандаЗапуска = СтруктураПараметровЗапуска.Запустить Тогда
		путьКТестам = МассивПараметров[НомерПараметраПутьКТестам];
		НомерОчередногоПараметра = НомерОчередногоПараметра + 1;
		Если МассивПараметров.Количество() > НомерОчередногоПараметра Тогда
			НомерОчередногоПараметра = НомерПараметраПутьКТестам+1;
			ИД_Теста = МассивПараметров[НомерОчередногоПараметра];

			Если НРег(ИД_Теста) <> СтруктураПараметровЗапуска.Режим_ПутьЛогФайла Тогда
				Если ВСтрокеСодержатсяТолькоЦифры(ИД_Теста) Тогда
					НомерТестаДляЗапуска = Число(ИД_Теста);
				Иначе
					НаименованиеТестаДляЗапуска = ИД_Теста;
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
	ИначеЕсли КомандаЗапуска = СтруктураПараметровЗапуска.ЗапуститьКаталог Тогда
		путьКТестам = МассивПараметров[НомерПараметраПутьКТестам];
		НомерОчередногоПараметра = НомерОчередногоПараметра + 1;
	КонецЕсли;
	
	Если МассивПараметров.Количество() > НомерОчередногоПараметра и (КомандаЗапуска = СтруктураПараметровЗапуска.Запустить или КомандаЗапуска = СтруктураПараметровЗапуска.ЗапуститьКаталог ) Тогда
		Режим = НРег(МассивПараметров[НомерОчередногоПараметра]);
		Если Режим = СтруктураПараметровЗапуска.Режим_ПутьЛогФайла Тогда
			Если МассивПараметров.Количество() > НомерОчередногоПараметра+1 Тогда
				НомерОчередногоПараметра = НомерОчередногоПараметра+1;
				ПутьЛогФайла = МассивПараметров[НомерОчередногоПараметра];
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
	ПараметрыЗапуска = Новый Структура;
	ПараметрыЗапуска.Вставить("Команда", КомандаЗапуска);
	ПараметрыЗапуска.Вставить("ПутьКТестам", путьКТестам);
	ПараметрыЗапуска.Вставить("НаименованиеТестаДляЗапуска", НаименованиеТестаДляЗапуска);
	ПараметрыЗапуска.Вставить("НомерТестаДляЗапуска", НомерТестаДляЗапуска);
	ПараметрыЗапуска.Вставить("ПутьЛогФайлаJUnit", ПутьЛогФайла);
	
	Возврат ПараметрыЗапуска;
КонецФункции

Функция ОбработатьПараметрыЗапуска(МассивПараметров)
	
	ПараметрыЗапуска = ПолучитьПараметрыЗапуска(МассивПараметров);
	Если Не ЗначениеЗаполнено(МассивПараметров) Тогда
		Возврат Ложь;
	КонецЕсли;
	КомандаЗапуска = ПараметрыЗапуска.Команда;
	путьКТестам = ПараметрыЗапуска.путьКТестам;
	НомерТестаДляЗапуска = ПараметрыЗапуска.НомерТестаДляЗапуска;
	НаименованиеТестаДляЗапуска = ПараметрыЗапуска.НаименованиеТестаДляЗапуска;
	ПутьЛогФайлаJUnit = ПараметрыЗапуска.ПутьЛогФайлаJUnit;
	
	Файл = Новый Файл(путьКТестам);
	Если Не Файл.Существует() Тогда
		ВызватьИсключение "Не найден файл/каталог "+путьКТестам;
	КонецЕсли;

	Если КомандаЗапуска = СтруктураПараметровЗапуска.Запустить Тогда
		Пути.Добавить(ПутьКТестам);
	ИначеЕсли КомандаЗапуска = СтруктураПараметровЗапуска.ПоказатьСписок Тогда
		Пути.Добавить(ПутьКТестам);
	ИначеЕсли КомандаЗапуска = СтруктураПараметровЗапуска.ЗапуститьКаталог Тогда
		Файлы = НайтиФайлы(ПутьКТестам, "*.os", Истина);
		Для Каждого Файл Из Файлы Цикл
			Если Файл.ИмяБезРасширения <> "testrunner" Тогда
				Пути.Добавить(Файл.ПолноеИмя);
			КонецЕсли;
		КонецЦикла;
		КомандаЗапуска = СтруктураПараметровЗапуска.Запустить;
	КонецЕсли;
	
	Если КомандаЗапуска = СтруктураПараметровЗапуска.ПоказатьСписок Тогда
		Сообщить("Список тестов:");
	КонецЕсли;

	ЗагрузитьТесты();

	Если КомандаЗапуска = СтруктураПараметровЗапуска.Запустить Тогда
		ВыполнитьВсеТесты();
	
		Сообщить(" ");

		Если КомандаЗапуска <> СтруктураПараметровЗапуска.ПоказатьСписок Тогда
			Если РезультатТестирования > ЗначенияСостоянияТестов.НеРеализован Тогда
				Сообщить("ОШИБКА: Есть непрошедшие тесты. Красная полоса");
			ИначеЕсли РезультатТестирования > ЗначенияСостоянияТестов.Прошел Тогда
				Сообщить("ОШИБКА: Есть нереализованные тесты. Желтая полоса");
			Иначе
				Сообщить("ОК. Зеленая полоса");
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
	Возврат Истина;
КонецФункции

Функция СоздатьСтруктуруПараметровЗапуска() Экспорт
	СтруктураПараметровЗапуска = Новый Структура;
	СтруктураПараметровЗапуска.Вставить("Запустить", НРег("-run"));
	СтруктураПараметровЗапуска.Вставить("ЗапуститьКаталог", НРег("-runall"));
	СтруктураПараметровЗапуска.Вставить("ПоказатьСписок", НРег("-show"));
	СтруктураПараметровЗапуска.Вставить("Режим_ПутьЛогФайла", НРег("xddReportPath"));
	Возврат СтруктураПараметровЗапуска;
КонецФункции

Функция ЗагрузитьТесты()
	Перем НомерТестаСохр;
	Перем Рез;
	
	Рез = Истина;
	
	Для Каждого ПутьТеста Из Пути Цикл
		Файл = Новый Файл(ПутьТеста);
		Если Файл.ЭтоКаталог() Тогда
			ВызватьИсключение "Пока не умею обрабатывать каталоги тестов";
		Иначе
			ПолноеИмяТестовогоСлучая = Файл.ПолноеИмя;
			ИмяКлассаТеста = СтрЗаменить(Файл.ИмяБезРасширения,"-","")+СтрЗаменить(Строка(Новый УникальныйИдентификатор),"-","");
			Если КомандаЗапуска = СтруктураПараметровЗапуска.ПоказатьСписок Тогда
				Сообщить("  Файл теста "+ПолноеИмяТестовогоСлучая);
			КонецЕсли;
			//Сообщить(ИмяКлассаТеста);
			Попытка
				ПодключитьСценарий(Файл.ПолноеИмя, ИмяКлассаТеста);
				Тест = Новый(ИмяКлассаТеста);
			Исключение
				ИнфоОшибки = ИнформацияОбОшибке();
				текстОшибки = ИнфоОшибки.Описание;
				Сообщить("Не удалось загрузить тест "+ПолноеИмяТестовогоСлучая+Символы.ПС+
					текстОшибки);
				Рез = Ложь;
				РезультатТестирования = ЗначенияСостоянияТестов.Сломался;
				Продолжить;
			КонецПопытки;
			
			МассивТестовыхСлучаев = ПолучитьТестовыеСлучаи(Тест, ПолноеИмяТестовогоСлучая);
			Если МассивТестовыхСлучаев = Неопределено Тогда
				Продолжить;
			КонецЕсли;
			
			Для Каждого ТестовыйСлучай Из МассивТестовыхСлучаев Цикл
				// Если ТипЗнч(ТестовыйСлучай) = Тип("Строка") Тогда
				Если ЭтоСтрока(ТестовыйСлучай) Тогда
					ИмяТестовогоСлучая = ТестовыйСлучай;
					ПараметрыТеста = Неопределено;
					ПредставлениеТеста = ИмяТестовогоСлучая;
				Иначе
					ВызватьИсключение "Не умею обрабатывать описание тестового случая из ПолучитьСписокТестов, отличный от строки"; //TODO
						// ИмяТестовогоСлучая = ТестовыйСлучай.ИмяТеста;
						// параметрыТеста = ТестовыйСлучай;
						// Если НЕ ТестовыйСлучай.Свойство("ПредставлениеТеста", ПредставлениеТеста) или не ЗначениеЗаполнено(ПредставлениеТеста) Тогда
							// ПредставлениеТеста = ИмяТестовогоСлучая;
						// КонецЕсли;
				КонецЕсли;
				
				ОписаниеТеста = Новый Структура;
				ОписаниеТеста.Вставить("ТестОбъект", Тест);
				ОписаниеТеста.Вставить("ИмяКласса", ИмяКлассаТеста);
				ОписаниеТеста.Вставить("ПолноеИмя", ПолноеИмяТестовогоСлучая);
				ОписаниеТеста.Вставить("Параметры", ПараметрыТеста);
				ОписаниеТеста.Вставить("ИмяМетода", ИмяТестовогоСлучая);

				НаборТестов.Добавить(ОписаниеТеста);
				
				НомерТеста = НаборТестов.Количество()-1;
				Если КомандаЗапуска = СтруктураПараметровЗапуска.ПоказатьСписок Тогда
					Сообщить("    Имя теста <"+ИмяТестовогоСлучая+">, №теста <"+НомерТеста+">");

				ИначеЕсли КомандаЗапуска = СтруктураПараметровЗапуска.Запустить Тогда
					Если НаименованиеТестаДляЗапуска = Неопределено Тогда
						Если НомерТеста = НомерТестаДляЗапуска Тогда
							НомерТестаСохр = НомерТеста;
						КонецЕсли;
					Иначе
						Если НРег(НаименованиеТестаДляЗапуска) = НРег(ИмяТестовогоСлучая) Тогда
							НомерТестаСохр = НомерТеста;
						КонецЕсли;
					КонецЕсли;
				КонецЕсли;
			КонецЦикла;			
		КонецЕсли;
	КонецЦикла;
	
	Если НомерТестаСохр <> Неопределено Тогда
		ОписаниеТеста = НаборТестов[НомерТестаСохр];
		НаборТестов.Очистить();
		НаборТестов.Добавить(ОписаниеТеста);
	КонецЕсли;
	
	Возврат Рез;
КонецФункции

Функция ВыполнитьВсеТесты()
	Если НаборТестов.Количество() > 0 Тогда
		НаборОшибок = Новый Соответствие;
		НаборНереализованныхТестов = Новый Соответствие;
		ДатаНачала = ТекущаяДата();
		
		СоздаватьОтчетТестированияВФорматеJUnitXML = ЗначениеЗаполнено(ПутьЛогФайлаJUnit);
		Если СоздаватьОтчетТестированияВФорматеJUnitXML Тогда
			ЗаписьXML = Неопределено;
			НачатьЗаписьВФайлОтчетаТестированияВФорматеJUnitXML(ЗаписьXML);
		КонецЕсли;
		
		Для Сч = 0 По НаборТестов.Количество() - 1 Цикл
			ОписаниеТеста = НаборТестов[Сч];

			НовыйРезультатТестирования = ВыполнитьТест(ОписаниеТеста, Сч);
			Если НовыйРезультатТестирования = ЗначенияСостоянияТестов.Прошел Тогда
				Сообщить("    Успешно");
			КонецЕсли;
			
			РезультатТестирования = ЗапомнитьСамоеХудшееСостояние(РезультатТестирования, НовыйРезультатТестирования);
			
			Сообщить("  ");
			Сообщить("---------------  ---------------  ---------------  ---------------  ");
			Сообщить("  ");
		КонецЦикла;
		
		ВывестиЛогТестирования();
		
		Если СоздаватьОтчетТестированияВФорматеJUnitXML Тогда
			ЗавершитьЗаписьВФайлОтчетаТестированияВФорматеJUnitXML(ЗаписьXML, ДатаНачала);
		КонецЕсли;
	КонецЕсли;
КонецФункции

Процедура ВывестиЛогТестирования()
	Если НаборОшибок.Количество() > 0 Тогда
		Сообщить(" ");
		Сообщить("Упали тесты. Количество "+НаборОшибок.Количество()+" шт :");
		Сч = 0;
		Для Каждого КлючЗначение Из НаборОшибок Цикл
			Сч = Сч + 1;
			ОписаниеТеста = КлючЗначение.Ключ;
			// СтруктураОшибки = КлючЗначение.Значение;
			Сообщить("    тест №"+Строка(Сч) + " : " + ОписаниеТеста.ИмяМетода + " : путь файла <"+ОписаниеТеста.ПолноеИмя+">");
		КонецЦикла;
	КонецЕсли;
	Если НаборНереализованныхТестов.Количество() > 0 Тогда
		Сообщить(" ");
		Сообщить("Есть нереализованные/пропущенные тесты. Количество "+НаборНереализованныхТестов.Количество()+" шт :");
		Сч = 0;
		Для Каждого КлючЗначение Из НаборНереализованныхТестов Цикл
			Сч = Сч + 1;
			ОписаниеТеста = КлючЗначение.Ключ;
			Сообщить("    тест №"+Строка(Сч) + " : " + ОписаниеТеста.ИмяМетода + " : путь файла <"+ОписаниеТеста.ПолноеИмя+">");
		КонецЦикла;
	КонецЕсли;
		// .Вставить(ОписаниеТеста, СтруктураОшибки);
КонецПроцедуры

Процедура НачатьЗаписьВФайлОтчетаТестированияВФорматеJUnitXML(ЗаписьXML)
	ЗаписьXML = Новый ЗаписьXML;
	ЗаписьXML.УстановитьСтроку("UTF-8");
	ЗаписьXML.ЗаписатьОбъявлениеXML();
	
КонецПроцедуры

Процедура ЗавершитьЗаписьВФайлОтчетаТестированияВФорматеJUnitXML(ЗаписьXML, ДатаНачала)
	ПроверитьНеРавенство(НаборТестов.Количество(), 0);
	
	ВсегоТестов = НаборТестов.Количество();
	КоличествоОшибок = НаборОшибок.Количество();
	КоличествоНереализованныхТестов = НаборНереализованныхТестов.Количество();
	
	ВремяВыполнения = ТекущаяДата() - ДатаНачала;
	
	ЗаписьXML.ЗаписатьНачалоЭлемента("testsuites");
	ЗаписьXML.ЗаписатьАтрибут("tests", XMLСтрока(ВсегоТестов));
	ЗаписьXML.ЗаписатьАтрибут("name", XMLСтрока("xUnitFor1C")); //TODO: указывать путь к набору тестов. 
	ЗаписьXML.ЗаписатьАтрибут("time", XMLСтрока(ВремяВыполнения));
	ЗаписьXML.ЗаписатьАтрибут("failures", XMLСтрока(КоличествоОшибок));
	ЗаписьXML.ЗаписатьАтрибут("skipped", XMLСтрока(КоличествоНереализованныхТестов)); // или disabled

	ЗаписьXML.ЗаписатьНачалоЭлемента("testsuite");	

	ОписаниеПервогоТеста = НаборТестов[0];
	ЗаписьXML.ЗаписатьАтрибут("name", ИмяТекущегоТеста(ОписаниеПервогоТеста.ПолноеИмя));
	
	ЗаписьXML.ЗаписатьНачалоЭлемента("properties");	
	ЗаписьXML.ЗаписатьКонецЭлемента();

	Для Каждого ОписаниеТеста Из НаборТестов Цикл
		ЗаполнитьРезультатТестовогоСлучая(ЗаписьXML, ОписаниеТеста, НаборОшибок, НаборНереализованныхТестов);
	КонецЦикла;	

	ЗаписьXML.ЗаписатьКонецЭлемента();
	
	СтрокаХМЛ = ЗаписьXML.Закрыть();
	
	ФайлТеста = Новый Файл(ОписаниеПервогоТеста.ПолноеИмя);

	ПутьОтчетаВФорматеJUnitxml = ПутьФайлаОтчетаТестированияВФорматеJUnitXML()+"\"+ФайлТеста.Имя+".xml";
	
	ЗаписьXML = Новый ЗаписьXML;
	ЗаписьXML.ОткрытьФайл(ПутьОтчетаВФорматеJUnitxml);
	ЗаписьXML.ЗаписатьБезОбработки(СтрокаХМЛ);// таким образом файл будет записан всего один раз, и не будет проблем с обработкой на билд-сервере TeamCity
	ЗаписьXML.Закрыть();
	Сообщить(" ");
	Сообщить("Путь к лог-файлу проверки в формате Ant.JUnit <"+ПутьОтчетаВФорматеJUnitxml+">");
	
	 // Сообщить(СтрокаХМЛ);
КонецПроцедуры

Процедура ЗаполнитьРезультатТестовогоСлучая(ЗаписьXML, ОписаниеТеста, НаборОшибок, НаборНереализованныхТестов)
		
	ЗаписьXML.ЗаписатьНачалоЭлемента("testcase");
	ЗаписьXML.ЗаписатьАтрибут("classname", ИмяТекущегоТеста(ОписаниеТеста.ПолноеИмя));
	ЗаписьXML.ЗаписатьАтрибут("name", ОписаниеТеста.ИмяМетода);
	//ЗаписьXML.ЗаписатьАтрибут("time", XMLСтрока(СтрокаТестов.ВремяВыполнения));
	
	СтруктураОшибки		= НаборОшибок.Получить(ОписаниеТеста);
	
	Если СтруктураОшибки = Неопределено Тогда
		СтруктураОшибки		= НаборНереализованныхТестов.Получить(ОписаниеТеста);
	КонецЕсли;
	
	Если СтруктураОшибки <> Неопределено Тогда
		СтрокаРезультат = ?(СтруктураОшибки.СостояниеВыполнения = ЗначенияСостоянияТестов.Сломался, "failure", "skipped");
		
		ЗаписьXML.ЗаписатьАтрибут("status", СтрокаРезультат);
		ЗаписьXML.ЗаписатьНачалоЭлемента(СтрокаРезультат);

		СтрокаОписание = СтруктураОшибки.Описание;
			// Поз = НайтиНедопустимыеСимволыXML(СтрокаОписание);
			// Если Поз <> 0 Тогда
				// Поз = 1;
				// КоличествоПовторов = СтрДлина(СтрокаОписание);
				
				// Пока КоличествоПовторов > 0 Цикл
					// Поз = НайтиНедопустимыеСимволыXML(СтрокаОписание, Поз);
					// Если Поз = 0 Тогда
						// Прервать;
					// КонецЕсли; 
					// КоличествоПовторов = КоличествоПовторов - 1;
					// СтрокаОписание = Лев(СтрокаОписание, Поз-1) + Сред(СтрокаОписание, Поз+1);
				// КонецЦикла; 
			// КонецЕсли; 
		XMLОписание = XMLСтрока(СтрокаОписание); 
		ЗаписьXML.ЗаписатьАтрибут("message", XMLОписание);
		
		ЗаписьXML.ЗаписатьКонецЭлемента();
	Иначе
		ЗаписьXML.ЗаписатьАтрибут("status", "passed");
	КонецЕсли;
	
	ЗаписьXML.ЗаписатьКонецЭлемента();
	
КонецПроцедуры

Функция ПутьФайлаОтчетаТестированияВФорматеJUnitXML()
	Возврат ?(ЗначениеЗаполнено(ПутьЛогФайлаJUnit), ПутьЛогФайлаJUnit, ТекущийКаталог());
КонецФункции

Функция ИмяТекущегоТеста(ПолныйПуть)
	Файл = Новый Файл(ПолныйПуть);
	Возврат Файл.ИмяБезРасширения;
	// Возврат СтрЗаменить(ТекущийСценарий().Источник, ТекущийКаталог()+"\", "")
КонецФункции

Функция ВыполнитьТест(ОписаниеТеста, Сч)
	Перем Рез;
	
	Тест = ОписаниеТеста.ТестОбъект;
	ИмяМетода = ОписаниеТеста.ИмяМетода;
	
	ПоказатьИнформациюПоТесту(ОписаниеТеста, Сч, ИмяМетода);
	
	Успешно = ВыполнитьПроцедуруТестовогоСлучая(Тест, "ПередЗапускомТеста", ИмяМетода, ОписаниеТеста);
	Если Не Успешно Тогда
		Рез = ЗначенияСостоянияТестов.Сломался;
	Иначе
	
		Попытка
			Рефлектор.ВызватьМетод(Тест, ИмяМетода);
			
			Рез = ЗначенияСостоянияТестов.Прошел;
		Исключение
			ИнфоОшибки = ИнформацияОбОшибке();
			текстОшибки = ИнфоОшибки.Описание;
			Если ЕстьОшибка_МетодОбъектаНеОбнаружен(текстОшибки, ИмяМетода) Тогда
				Рез = ВывестиОшибкуВыполненияТеста(ЗначенияСостоянияТестов.НеРеализован, "Не найден тестовый метод "+ИмяМетода, ОписаниеТеста, текстОшибки, ИнфоОшибки);
				// ВывестиОшибку("Не найден тестовый метод "+ИмяМетода+" - тест <"+ИмяМетода+">, файл <"+ОписаниеТеста.ПолноеИмя+">: "+Символы.ПС+"    "+текстОшибки);
				// Рез = ЗначенияСостоянияТестов.НеРеализован;
			Иначе
				Если ВыводитьОшибкиПодробно Тогда
					текстОшибки = ИнфоОшибки.ПодробноеОписаниеОшибки();
				КонецЕсли;
				Рез = ВывестиОшибкуВыполненияТеста(ЗначенияСостоянияТестов.Сломался, "", ОписаниеТеста, текстОшибки, ИнфоОшибки);
			КонецЕсли;
		КонецПопытки;
		
		Успешно = ВыполнитьПроцедуруТестовогоСлучая(Тест, "ПослеЗапускаТеста", ИмяМетода, ОписаниеТеста);
		Если Не Успешно Тогда
			Рез = ЗначенияСостоянияТестов.Сломался;
		КонецЕсли;
	КонецЕсли;

	Возврат Рез;	
КонецФункции

Функция ВывестиОшибкуВыполненияТеста(СостояниеВыполнения, ПредставлениеОшибки, ОписаниеТеста, текстОшибки, ИнфоОшибки)
	ИмяМетода = ОписаниеТеста.ИмяМетода;
	
	ВывестиОшибку(?(ПредставлениеОшибки="", "", ПредставлениеОшибки +" - ") + "Упал тест <"+ИмяМетода+">, файл <"+ОписаниеТеста.ПолноеИмя+">: "+Символы.ПС+"    "+текстОшибки);
	
	СтруктураОшибки = Новый Структура();
	
		// ЭтоСтрокаДереваУФ = Ложь;
		// РодительскаяСтрока = РодительскаяСтрока(СтрокаДереваТестов, ЭтоСтрокаДереваУФ);
		// СтруктураОшибки.Вставить("ИмяТестовогоНабора", РодительскаяСтрока.Имя);
	СтруктураОшибки.Вставить("ИмяТестовогоНабора", ИмяМетода);
	
	стИнфоОшибки = Новый Структура("СостояниеВыполнения,ИмяМодуля,ИсходнаяСтрока,НомерСтроки,Описание"); //,Причина");
	ЗаполнитьЗначенияСвойств(стИнфоОшибки, ИнфоОшибки);
	стИнфоОшибки.Вставить("Причина",  Неопределено);
	
	стИнфоОшибкиЦикл = стИнфоОшибки;
	ИнфоОшибки = ИнфоОшибки.Причина;
	Пока ИнфоОшибки <> Неопределено Цикл
		стИнфоОшибкиЦикл.Причина = Новый Структура("ИмяМодуля,ИсходнаяСтрока,НомерСтроки,Описание");
		стИнфоОшибкиЦикл = стИнфоОшибкиЦикл.Причина;
		ЗаполнитьЗначенияСвойств(стИнфоОшибкиЦикл, ИнфоОшибки);
		стИнфоОшибкиЦикл.Вставить("Причина",  Неопределено);

		ИнфоОшибки = ИнфоОшибки.Причина;
	КонецЦикла;
	
	ИмяТестовогоСлучаяДляОписанияОшибки = ИмяМетода; //?(СтрокаДереваТестов.Имя <> ИмяТестовогоСлучая, СтрокаДереваТестов.Имя, ИмяТестовогоСлучая);
	
	СтруктураОшибки.Вставить("ИмяТестовогоСлучая", ИмяТестовогоСлучаяДляОписанияОшибки);
	СтруктураОшибки.Вставить("СостояниеВыполнения",  СостояниеВыполнения);
	
	СтруктураОшибки.Вставить("Описание",              текстОшибки);
	// СтруктураОшибки.Вставить("СообщениеОбОшибке",     СообщениеОбОшибке);
	СтруктураОшибки.Вставить("ИнфоОшибки",            стИнфоОшибки);
	// СтруктураОшибки.Вставить("ЕстьПараметрыТеста",    СтрокаДереваТестов.ЕстьПараметрыТеста);
	// СтруктураОшибки.Вставить("ПараметрыТеста",        СтрокаДереваТестов.ПараметрыТеста);
	СтруктураОшибки.Вставить("ПолныйПуть",            ОписаниеТеста.ПолноеИмя);
	// СтруктураОшибки.Вставить("УИДСтрокиДерева",       Сч); //СтрокаДереваТестов._guid);
	
	// Если ЭтоСтрокаДереваУФ Тогда
		// СтруктураОшибки.Вставить("Идентификатор",       СтрокаДереваТестов.ПолучитьИдентификатор());
	// Иначе
		// СтруктураОшибки.Вставить("Идентификатор",       Неопределено);
	// КонецЕсли;
	
	//НужныйТекстОшибки = ВывестиОшибку(СтруктураОшибки);
	// ВывестиОшибку("Упал тест <"+ИмяМетода+">, файл <"+ОписаниеТеста.ПолноеИмя+">: "+Символы.ПС+"    "+текстОшибки);
	
	Если СостояниеВыполнения = ЗначенияСостоянияТестов.Сломался Тогда
		НаборОшибок.Вставить(ОписаниеТеста, СтруктураОшибки);
	Иначе
		НаборНереализованныхТестов.Вставить(ОписаниеТеста, СтруктураОшибки);
	КонецЕсли;
	
	//ЗарегистрироватьОшибкуТеста(НужныйТекстОшибки, ИмяТестовогоСлучаяДляОписанияОшибки, СтрокаДереваТестов.ПолныйПуть);
	
	// Попытка
		// ОповеститьОСобытии("TestFailed", СтрокаДереваТестов);
	// Исключение
	// КонецПопытки;

	Возврат СостояниеВыполнения; //ЗначенияСостоянияТестов.Сломался;
КонецФункции

Функция ВыполнитьПроцедуруТестовогоСлучая(Тест, ИмяПроцедуры, ИмяТестовогоСлучая, ОписаниеТеста)
	Успешно = Ложь;
	
	ПолноеИмя = ОписаниеТеста.ПолноеИмя;
	Попытка
		Рефлектор.ВызватьМетод(Тест,ИмяПроцедуры);
		Успешно = Истина;
	Исключение
		ИнфоОшибки = ИнформацияОбОшибке();
		текстОшибки = ИнфоОшибки.Описание;
		
		Если ЕстьОшибка_МетодОбъектаНеОбнаружен(текстОшибки, ИмяПроцедуры) Тогда
			Успешно = Истина;
		Иначе
			Рез = ВывестиОшибкуВыполненияТеста(ЗначенияСостоянияТестов.Сломался, "Упал метод "+ИмяПроцедуры, ОписаниеТеста, текстОшибки, ИнфоОшибки);
		КонецЕсли;
	КонецПопытки;

	Возврат Успешно;
КонецФункции

Функция ПолучитьТестовыеСлучаи(ТестОбъект, ПолноеИмяОбъекта)

	Попытка
        
		МассивТестовыхСлучаев = ТестОбъект.ПолучитьСписокТестов(ЭтотОбъект);
		
	Исключение
		текстОшибки = ИнформацияОбОшибке().Описание; //ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()) ;
		
		// TODO если не использовать переменную ниже, а поставить вызов метода в условие, то будет глюк - внутрь условия не попадаем !
		ЕстьОшибка_МетодОбъектаНеОбнаружен = ЕстьОшибка_МетодОбъектаНеОбнаружен(текстОшибки, "ПолучитьСписокТестов");
		Если НЕ ЕстьОшибка_МетодОбъектаНеОбнаружен Тогда
		
			ВывестиОшибку("Набор тестов не загружен: " + ПолноеИмяОбъекта + "
			|	Ошибка получения списка тестовых случаев: " + ОписаниеОшибки());
			
			ТестОбъект = Неопределено;
		КонецЕсли;
		
		Возврат Неопределено;			
				
	КонецПопытки;

	// Если ТипЗнч(МассивТестовыхСлучаев) <> Тип("Массив") Тогда
	Если Строка(МассивТестовыхСлучаев) <> "Массив" Тогда
		
		ВывестиОшибку("Набор тестов не загружен: " + ПолноеИмяОбъекта + "
		|	Ошибка получения списка тестовых случаев: вместо массива имен тестовых случаев получен объект <" + Строка(МассивТестовыхСлучаев) + ">");
				// |	Ошибка получения списка тестовых случаев: вместо массива имен тестовых случаев получен объект <" + Строка(ТипЗнч(МассивТестовыхСлучаев)) + ">");
		ТестОбъект = Неопределено;
		Возврат Неопределено;			
		
	КонецЕсли;
	
	Если НЕ ПроверитьМассивТестовыхСлучаев(МассивТестовыхСлучаев, ТестОбъект, ПолноеИмяОбъекта) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Возврат МассивТестовыхСлучаев;
		
КонецФункции

Функция ПроверитьМассивТестовыхСлучаев(МассивТестовыхСлучаев, ТестОбъект, ПолноеИмяОбъекта)
	Для каждого данныеТеста из МассивТестовыхСлучаев Цикл
		// Если ТипЗнч(данныеТеста) = Тип("Строка") Тогда
		Если ЭтоСтрока(данныеТеста) Тогда //Тип("Строка") Тогда
			Продолжить;
		КонецЕсли;
		
		// Если ТипЗнч(данныеТеста) <> Тип("Структура") Тогда
		Если Строка(данныеТеста) <> "Структура" Тогда
			ВывестиОшибку("Набор тестов не загружен: " + ПолноеИмяОбъекта + "
			|	Ошибка получения структуры описания тестового случая: " + ОписаниеОшибки());
			Возврат Ложь;
		КонецЕсли;
		Если НЕ данныеТеста.Свойство("ИмяТеста") Тогда
			ВывестиОшибку("Набор тестов не загружен: " + ПолноеИмяОбъекта + "
			|	Не задано имя теста в структуре описания тестового случая: " + ОписаниеОшибки());
			Возврат Ложь;
		КонецЕсли;
	КонецЦикла;
	Возврат Истина;
КонецФункции

Функция ЕстьОшибка_МетодОбъектаНеОбнаружен(текстОшибки, имяМетода)
	Результат = Ложь;
	Если Найти(текстОшибки, "Метод объекта не обнаружен ("+имяМетода+")") > 0 
		ИЛИ Найти(текстОшибки, "Object method not found ("+имяМетода+")") > 0  Тогда
		Результат = Истина;
	КонецЕсли;
	
	Возврат Результат;
КонецФункции

Процедура ПоказатьИнформациюПоТесту(ОписаниеТеста, Знач Номер, Знач Тест)
	Сообщить("---------------------------------------------------------");
	Сообщить("    Тест №"+Строка(Номер) + ": " + Тест + ": "+ОписаниеТеста.ПолноеИмя);
	Сообщить("  ");
КонецПроцедуры

// Устанавливает новое текущее состояние выполнения тестов
// в соответствии с приоритетами состояний:
// 		Красное - заменяет все другие состояния
// 		Желтое - заменяет только зеленое состояние
// 		Зеленое - заменяет только серое состояние (тест не выполнялся ни разу).
Функция ЗапомнитьСамоеХудшееСостояние(ТекущееСостояние, НовоеСостояние)
	
	ТекущееСостояние = Макс(ТекущееСостояние, НовоеСостояние);
	Возврат ТекущееСостояние;
	
КонецФункции

Функция ПредставлениеПериода(ДатаНачала, ДатаОкончания, ФорматнаяСтрока = Неопределено)
	Возврат "с "+ДатаНачала+" по "+ДатаОкончания;
КонецФункции

Функция ЭтоСтрока(Значение)
	Возврат Строка(Значение) = Значение;
КонецФункции

Функция ФорматДСО(ДопСообщениеОшибки)
	Если ДопСообщениеОшибки = "" Тогда
		Возврат "";
	КонецЕсли;
	
	Возврат Символы.ПС + ДопСообщениеОшибки;
КонецФункции

Функция ВСтрокеСодержатсяТолькоЦифры(Знач ИсходнаяСтрока) Экспорт
	
	рез = Ложь;
	ДлинаСтроки = СтрДлина(ИсходнаяСтрока);
	Для Сч = 1 По ДлинаСтроки Цикл
		ТекущийСимвол = КодСимвола(Сред(ИсходнаяСтрока, Сч, 1));
		Если 48 <= ТекущийСимвол И ТекущийСимвол <= 57 Тогда
			рез = Истина;
		Иначе
			рез = Ложь;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	Возврат рез;	
КонецФункции

Процедура СоздатьСостояниеТестов()
	//{ Состояния тестов - ВАЖЕН порядок заполнения в мЗначенияСостоянияТестов, используется в ЗапомнитьСамоеХудшееСостояние
	ЗначенияСостоянияТестов = Новый Структура;
	ЗначенияСостоянияТестов.Вставить("НеВыполнялся", -1);
	ЗначенияСостоянияТестов.Вставить("Прошел"		, 0); // код 0 используется в командной строке для показа нормального завершения
	ЗначенияСостоянияТестов.Вставить("НеРеализован", 2);
	ЗначенияСостоянияТестов.Вставить("Сломался"	, 3);
	//} Состояния тестов
КонецПроцедуры

// Выводит сообщение. В тестах ВСЕГДА должна использоваться ВМЕСТО метода Сообщить().
// 
Функция ВывестиСообщение(ТекстСообщения) Экспорт	
	
	// Если ВыводЛогаВФорматеTeamCity Тогда
		// ТекстСообщения = СтрЗаменить(ТекстСообщения,"|","||");
		// ТекстСообщения = СтрЗаменить(ТекстСообщения,"'","|'");
		// ТекстСообщения = СтрЗаменить(ТекстСообщения,"[","|[");
		// ТекстСообщения = СтрЗаменить(ТекстСообщения,"]","|]");
		// ТекстСообщения = СтрЗаменить(ТекстСообщения,Символы.ВК,"|r");
		// ТекстСообщения = СтрЗаменить(ТекстСообщения,Символы.ПС,"|n");		
		
		// Сообщить("##teamcity[message text='"+ТекстСообщения+"' errorDetails='' status='"+мСоответствиеСтатусовДляTeamCity[Статус]+"']");
	// Иначе
		Сообщить(ТекстСообщения);
	// КонецЕсли;
	
КонецФункции

// Вызывает исключение с заданным текстом ошибки для прерывания выполнения тестового случая.
// 
Функция ПрерватьТест(ТекстОшибки) Экспорт
	
	ВызватьИсключение ТекстОшибки;
	
КонецФункции

Функция ВывестиОшибку(Ошибка) Экспорт
	
	НужныйТекстОшибки = Ошибка; //ПолучитьРазвернутыйТекстОшибки(Ошибка);
	
	ВывестиСообщение("ОШИБКА: "+НужныйТекстОшибки);

	Возврат НужныйТекстОшибки;
КонецФункции

Процедура Инициализация()
	Пути = Новый Массив;
	НаборТестов = Новый Массив;
	Рефлектор = Новый Рефлектор;

	СоздатьСостояниеТестов();
	СоздатьСтруктуруПараметровЗапуска();
	
	РезультатТестирования = ЗначенияСостоянияТестов.НеВыполнялся;
КонецПроцедуры

ВыводитьОшибкиПодробно = Ложь;

ВыполнитьТесты(АргументыКоманднойСтроки);

ЗавершитьРаботу(ПолучитьРезультатТестирования());
