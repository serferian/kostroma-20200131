#language: ru
@tree

Функционал: Счета на оплату покупателя

Как менеджер по продажам
Я хочу создавать новые счета на оплату
Чтобы ускорить процесс оплаты и покупки товара 

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

# Сценарий: Ввод нового путем копирования существующего
# Сценарий: Создание нового счета на основании заказа
# Сценарий: Изменение существующего счета на оплату
# Сценарий: Удаление счета на оплату

Сценарий: Создание нового счета

	# Дано Удаляю документы "_ДемоСчетНаОплатуПокупателю" за текущий день
	Когда я открываю форму списка счетов
		И В панели разделов я выбираю 'Интегрируемые подсистемы'
		И Я нажимаю кнопку командного интерфейса 'Демо: Счета на оплату покупателям'
	И создаю новый документ
		И я нажимаю на кнопку с именем 'ФормаСоздать'
	И заполняю шапку документа
		Тогда открылось окно 'Демо: Счет на оплату покупателю (создание)'
		И я нажимаю кнопку выбора у поля "Партнер"
		Тогда открылось окно 'Демо: Партнеры'
		И Я закрываю окно 'Демо: Партнеры'
		Тогда открылось окно 'Демо: Счет на оплату покупателю (создание)'
		И я нажимаю кнопку выбора у поля "Организация"
		Тогда открылось окно 'Демо: Организации'
		И в таблице "Список" я перехожу к строке:
			| Код       | Наименование         |
			| 000000001 | Новые технологии ООО |
		И в таблице "Список" я выбираю текущую строку
		Тогда открылось окно 'Демо: Счет на оплату покупателю (создание) *'
		И из выпадающего списка "Партнер" я выбираю по строке 'торгов'
		И из выпадающего списка "Контрагент" я выбираю по строке 'тор'
		И я нажимаю кнопку выбора у поля "Договор"
		Тогда открылось окно 'Демо: Договоры контрагентов'
		И в таблице "Список" я выбираю текущую строку
		Тогда открылось окно 'Демо: Счет на оплату покупателю *'
		И я нажимаю кнопку выбора у поля "Подразделение"
		Тогда открылось окно 'Демо: Подразделения'
		И в таблице "Список" я перехожу к строке:
			| Код       | Наименование |
			| 000000001 | Отдел продаж |
		И в таблице "Список" я выбираю текущую строку

	# И добавляю 1 товар в таблицу
	И записываю документ
		И я нажимаю на кнопку 'Записать'
		И     я запоминаю значение поля "Номер" как "ПеременнаяНомер"
	И провожу документ
		И я нажимаю на кнопку 'Провести и закрыть'
		И я жду закрытия окна 'Демо: Счет на оплату покупателю * от *' в течение 20 секунд

	Тогда в списке вижу новый проведенный счет

		# Когда я отбираю документы
		# 	И я нажимаю на кнопку с именем 'ФормаУстановитьИнтервал'
		# 	Тогда открылось окно 'Выберите период'
		# 	И я нажимаю на гиперссылку "SwitchText"
		# 	И я перехожу к закладке "Group standard period"
		# 	И в таблице "PeriodVariantTable" я активизирую поле "Значение"
		# 	И я нажимаю на кнопку 'Выбрать'
		Тогда таблица "Список" содержит строки:
	# 	Тогда таблица "Список" стала равной:
			| Номер                      | Партнер                      | Организация          |
			| $ПеременнаяНомер$          | 'Торговый дом "Комплексный"' | Новые технологии ООО |
			# | 14:27      | НТ-00000001 | 'Торговый дом "Комплексный"' | Новые технологии ООО |

		Тогда я запоминаю строку '$ПеременнаяНомер$' как переменную "НомерДокумента" глобально

Сценарий: Печать счета на оплату

	Дано есть документ счет на оплату

		Когда я открываю форму списка счетов
			И В панели разделов я выбираю 'Интегрируемые подсистемы'
			И Я нажимаю кнопку командного интерфейса 'Демо: Счета на оплату покупателям'
		И в таблице "Список" я перехожу к строке:
			| Номер |
			|    $$НомерДокумента$$    |
	Когда я формирую печатную форму счета
		И я нажимаю на кнопку 'Счет на оплату'
	Тогда сформированная печатная форма совпадает с макетом-образцом
		И Табличный документ "ТекущаяПечатнаяФорма" равен макету "fixtures\СчетНаОплатуЭталон.mxl" по шаблону