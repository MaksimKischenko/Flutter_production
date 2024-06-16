
function saveDocumentToFile(doc, fileName) {
  // Create new instance of Packer for the docx module
  const packer = new Packer()
  // Create a mime type that will associate the new file with Microsoft Word
  const mimeType =
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
  // Create a Blob containing the Document instance and the mimeType
  packer.toBlob(doc).then(blob => {
    const docblob = blob.slice(0, blob.size, mimeType)
    // Save the file using saveAs from the file-saver package
    saveAs(docblob, fileName)
  })
}

function aboutSearchingPayments(
  listLength, dateFrom, dateTo, name, 
  payDate, payTime, paySumm, pemaltySum, deptFilial,
  terminalDept, externalSystemPayerId, 
  supplierName, supplierUnp, supplierAccount,
  bankBik, consolidatedDocPayString, payerAccount, externalSystemPaymentId 
) {

  let doc = new Document()

  //if(terminalDept == null)

  doc.theme = {
    font: {
      normal: {
        family: "Times New Roman",
        color: "303856",
      },
      header: { family: "Times New Roman" },
      
    },
    styles: {

    },
    title: {
      color: "303856",
    },
    headings: {
      one: {
        color: "303856",
      },
      two: {
        color: "303856",
      },
    },
  }

  doc.Styles.createParagraphStyle("paddingAfterContent")
    .size(28)
    .justified()
    .spacing({ after: 250 })

  doc.Styles.createParagraphStyle("paddingBeforeContent")
    .size(28)
    .justified()
    .spacing({ before: 500 })

  doc.Styles.createParagraphStyle("simpleStyleWithoutPadding")
    .size(28)
    .justified()


  doc.createParagraph('О розыске платежей').style("paddingAfterContent")
  doc.createParagraph(' '.repeat(10) + "Сообщаем, что в период с " + dateFrom + " по " + dateTo + " (включительно) совершены платежи на имя:").style("simpleStyleWithoutPadding")
  for (let i = 0; i < listLength; i++) {
    doc.createParagraph(' '.repeat(10) + (i + 1) + ". " + name[i] + "; " + "дата и время платежа: " + payDate[i] + " в " + payTime[i] + ";  " + "сумма платежа: " + paySumm[i] + " бел. руб., в том числе пеня: " + pemaltySum[i] + " бел. руб.; " + "место совершения платежа: отделение " + deptFilial[i] + "/" + terminalDept[i] + "; " 
    + " номер плательщика ЕРИП: " + externalSystemPayerId[i] + "; " + "получатель платежа: " + supplierName[i] + " УНП " + supplierUnp[i] + ", " + " р/с  " + supplierAccount[i] + " в филиале №" + bankBik[i] + "; " + "назначение платежа: " + consolidatedDocPayString[i] + "; " 
    + "номер договора: " + payerAccount[i] + "; " + "номер операции в ЕРИП: " + externalSystemPaymentId[i]+ "." ).style("simpleStyleWithoutPadding")
  }
  doc.createParagraph('Должность'	+ ' '.repeat(80) + 'Ф.И.О.').style("paddingBeforeContent")

  saveDocumentToFile(doc, "О розыске платежей.docx")
}


function paymentSearchProtocol(
  dateTimeReport, dateFrom, dateTo, paymentId, paymentIds, payerName, paymentNames, payerIn,
  payerDoc, payerAddress, payerAccount, supplierName, supplierAccount,
  bik, supplierUnp, budgetCode, serviceName, paySumMin, paySumMax, receiptNo, systemPaymentId,
  listLength, name, payDate, payTime, paySumm, pemaltySum, terminalDept, deptFilial,
  externalSystemPayerId, supplierNameResponse, supplierUnpResponse,
  supplierAccountResponse, bankBik, serviceNameResponse, payerAccountResponse, externalSystemPaymentId, 
  consolidatedDocId, consolidatedDocDate, consolidatedDocSum, consolidatedDocPayString
) {

  let doc = new Document()


  doc.theme = {
    font: {
      normal: {
        family: "Times New Roman",
        color: "303856",
      },
      header: { family: "Calibri Light" },
    },
    title: {
      color: "4ABDAC",
    },
    headings: {
      one: {
        color: "FC4A1A",
      },
      two: {
        color: "F7B733",
      },
    },
  }

  doc.Styles.createParagraphStyle("paddingAfterContent")
    .size(28)
    .justified()
    .spacing({ after: 150 })

  doc.Styles.createParagraphStyle("paddingBeforeContent")
    .size(28)
    .justified()
    .spacing({ before: 150 })

  doc.Styles.createParagraphStyle("simpleStyleWithoutPadding")
    .size(28)
    .justified()


  doc.Styles.createParagraphStyle("simpleIntroStyle")
    .size(28)
    .justified()
    .spacing({ after: 250 })


  doc.Styles.createParagraphStyle("simpleFinishStyle")
    .size(28)
    .justified()
    .spacing({ before: 500 })


  doc.createParagraph('ОАО "АСБ"Беларусбанк"').style("simpleIntroStyle").style("paddingAfterContent")
  doc.createParagraph('Протокол розыска платежей в системе АИС Расчет').center().style("paddingAfterContent")
  doc.createParagraph('Дата и время: ' + dateTimeReport).style("simpleStyleWithoutPadding")
  doc.createParagraph('Параметры поиска: ').style("simpleStyleWithoutPadding")
  if(dateFrom != "") {
    doc.createParagraph('Период с: ' + dateFrom + ' до ' + dateTo + ' (включительно)').style("simpleStyleWithoutPadding")
  }
  if(paymentId != -1) {
    doc.createParagraph('ID платежа: ' + paymentId).style("simpleStyleWithoutPadding")
  }
  if(paymentIds != "") {
    doc.createParagraph('ID платежей: ' + paymentIds).style("simpleStyleWithoutPadding")
  }  
  if(payerName != "") {
    doc.createParagraph('ФИО плательщика: ' + payerName).style("simpleStyleWithoutPadding")
  }
  if(paymentNames != "") {
    doc.createParagraph('ФИО плательщиков: ' + paymentNames).style("simpleStyleWithoutPadding")
  }  
  if(payerIn != "") {
    doc.createParagraph('Идентификационный номер паспорта плательщика: ' + payerIn).style("simpleStyleWithoutPadding")
  }
  if(payerDoc != "") {
    doc.createParagraph('Cерия/номер паспорта: ' + payerDoc).style("simpleStyleWithoutPadding")
  }
  if(payerAddress != "") {
    doc.createParagraph('Адрес плательщика: ' + payerAddress).style("simpleStyleWithoutPadding")
  }
  if(payerAccount != "") {
    doc.createParagraph('Лицевой счет плательщика: ' + payerAccount).style("simpleStyleWithoutPadding")
  }
  if(supplierName != "") {
    doc.createParagraph('Наименование производителя услуги: ' + supplierName).style("simpleStyleWithoutPadding")
  }
  if(supplierAccount != "") {
    doc.createParagraph('Номер расчетного счета производителя услуг: ' + supplierAccount).style("simpleStyleWithoutPadding")
  }
  if(bik != "") {
    doc.createParagraph('БИК банка расчетного счета производителя услуг: ' + bik).style("simpleStyleWithoutPadding")
  }
  if(supplierUnp != "") {
    doc.createParagraph('УНП производителя услуг: ' + supplierUnp).style("simpleStyleWithoutPadding")
  }
  if(budgetCode != -1) {
    doc.createParagraph('Код платежа в бюджет: ' + budgetCode).style("simpleStyleWithoutPadding")
  }
  if(serviceName != "") {
    doc.createParagraph('Наименование услуги: ' + serviceName).style("simpleStyleWithoutPadding")
  }
  if(paySumMin != -1) {
    doc.createParagraph('Сумма платежа от ' + paySumMin + ' до ' + paySumMax + ' бел. руб. включительно').style("simpleStyleWithoutPadding")
  }
  if(receiptNo != "") {
    doc.createParagraph('Номер чека: ' + receiptNo).style("simpleStyleWithoutPadding")
  }
  if(systemPaymentId != "") {
    doc.createParagraph('Номера операции во внешней системе: ' + systemPaymentId).style("simpleStyleWithoutPadding")
  }

  for (let i = 0; i < listLength; i++) {
    doc.createParagraph(' '.repeat(10) + (i + 1) + ". " + name[i] + "; " + "дата и время платежа: " + payDate[i] + " в " + payTime[i] + ";  " + "сумма платежа: " + paySumm[i] + " бел. руб., в том числе пеня: " + pemaltySum[i] + " бел. руб.; " + "место совершения платежа: отделение " + deptFilial[i] + "/" + terminalDept[i] + "; " 
    + " номер плательщика ЕРИП: " + externalSystemPayerId[i] + "; " + "получатель платежа: " + supplierNameResponse[i] + " УНП " + supplierUnpResponse[i] + ", " + " р/с  " + supplierAccountResponse[i] + " в филиале №" + bankBik[i] + "; " + "вид платежа: " + serviceNameResponse[i] + "; " 
    + "номер договора: " + payerAccountResponse[i] + "; " + "номер операции в ЕРИП: " + externalSystemPaymentId[i]+ "." ).style("paddingBeforeContent")
    doc.createParagraph(' '.repeat(10) + "Платежный документ № " + consolidatedDocId[i] + " от " + consolidatedDocDate[i] + " на сумму " + consolidatedDocSum[i] + " руб., " + consolidatedDocPayString[i] + '.').style("simpleStyleWithoutPadding")
  }
  doc.createParagraph('Ответственный исполнитель: 				П.Н. Лешкович').style("simpleFinishStyle")


  saveDocumentToFile(doc, "Протокол розыска платежей.docx")
}

function infoPaymentsReference(
  dateTimeReport, name, documentName, passportSeria, passportNumber, documentPlace, passportIn,
  adress, payDate, dateFrom, dateTo, deptFilial, terminalDept, supplierName, supplierAccount,
  bankBik, paySumm, paySummWithString, serviceName 
) {
  let doc = new Document()

  doc.theme = {
    font: {
      normal: {
        family: "Times New Roman",
        color: "303856",
      },
      header: { family: "Calibri Light" },
    },
    title: {
      color: "4ABDAC",
    },
    headings: {
      one: {
        color: "FC4A1A",
      },
      two: {
        color: "F7B733",
      },
    },
  }

  doc.Styles.createParagraphStyle("paddingAfterContent")
    .size(28)
    .justified()
    .spacing({ after: 150 })

  doc.Styles.createParagraphStyle("paddingAfterContent2")
    .size(24)
    .justified()
    .spacing({ after: 150 })

  doc.Styles.createParagraphStyle("paddingBeforeContent")
    .size(28)
    .justified()
    .spacing({ before: 150 })

  doc.Styles.createParagraphStyle("simpleStyleWithoutPadding")
    .size(28)
    .justified()



  doc.Styles.createParagraphStyle("simpleIntroStyle")
    .size(28)
    .justified()
    .spacing({ after: 250 })


  doc.Styles.createParagraphStyle("simpleFinishStyle")
    .size(28)
    .justified()
    .spacing({ before: 500 })

  doc.Styles.createParagraphStyle("simpleFinishStyle2")
    .size(28)
    .justified()
    .spacing({ before: 500 })
    .spacing({ after: 250 })

    doc.createParagraph('СПРАВКА').style("simpleIntroStyle").style("paddingAfterContent")
    doc.createParagraph('Об осуществленных платежах').style("simpleIntroStyle").style("paddingAfterContent")
    doc.createParagraph(dateTimeReport + " №__").style("simpleStyleWithoutPadding")
    doc.createParagraph('ОАО "АСБ"Беларусбанк"').style("paddingAfterContent2")
    doc.createParagraph(' '.repeat(10) + name + ', ' + documentName + ' серии ' + passportSeria + ' № ' + passportNumber + ' выдан ' + documentPlace + ', ' + passportIn + ', ').style("simpleStyleWithoutPadding")
    doc.createParagraph('зарегистрированному(ой) по адрессу: ' + adress).style("simpleStyleWithoutPadding")
    doc.createParagraph('осуществил(a)/не осуществлял(а) платеж(и): ').style("simpleStyleWithoutPadding")    
    doc.createParagraph(payDate + 'г./ в период с ' + dateFrom + 'г. по ' + dateTo + 'г.').style("simpleStyleWithoutPadding")
    doc.createParagraph('в ' + deptFilial + '/' + terminalDept + ' подразделении ОАО "АСБ БЕЛАРУСБАНК"').style("simpleStyleWithoutPadding")
    doc.createParagraph('на счет(а) ' + supplierName).style("simpleStyleWithoutPadding")
    doc.createParagraph('№ ' + supplierAccount + ', открытый(е) в ' + bankBik + ',').style("simpleStyleWithoutPadding")
    doc.createParagraph('в сумме ' + paySumm + ', ' + paySummWithString).style("simpleStyleWithoutPadding")
    doc.createParagraph('за ' + serviceName + '.').style("paddingAfterContent")
    doc.createParagraph(' '.repeat(10) + 'Справка дана для предоставления по месту требования').style("simpleFinishStyle2")
    doc.createParagraph('Руководитель' + ' '.repeat(20) + 'Подпись' + ' '.repeat(20) + 'Расшифровка подписи').style("paddingAfterContent")
    doc.createParagraph('Отметка об исполнителе').style("simpleFinishStyle")
    doc.createParagraph('Я, _______________________________________, подтверждаю получение').style("simpleFinishStyle")
    doc.createParagraph('справки «Об осуществленных платежах» № ________ от _____________. ').style("paddingAfterContent")
    doc.createParagraph('______________	__________________	___________________________').style("simpleStyleWithoutPadding")
    doc.createParagraph(' '.repeat(12) + '(дата)' + ' '.repeat(22) + '(подпись)'+ ' '.repeat(30) + '(инициалы, фамилия)').style("paddingAfterContent2")
    doc.createParagraph('______________	__________________	___________________________').style("simpleStyleWithoutPadding")
    doc.createParagraph(' '.repeat(8) + '(должность)' + ' '.repeat(15) + '(подпись)'+ ' '.repeat(22) + '(инициалы, фамилия работника банка)').style("paddingAfterContent2")
    doc.createParagraph('Департамент розниченого бизнеса').style("simpleFinishStyle")

    saveDocumentToFile(doc,"Справка об осуществленных платежах.docx")
  
}

