Функция ПолучитьКурсУпрВалюты(Дата) Экспорт
	Структура = РегистрыСведений.КурсыВалют.ПолучитьПоследнее(Дата, Новый Структура("Валюта", Константы.ВалютаУправленческогоУчета.Получить()));
	Возврат ?(Структура.Курс = 0, 1, Структура.Курс);
КонецФункции