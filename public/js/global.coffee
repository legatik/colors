$(document).ready () ->
  
  console.log "globalJS"
  
  jQuery.browser = {};
  jQuery.browser.mozilla = /mozilla/.test(navigator.userAgent.toLowerCase()) && !/webkit/.test(navigator.userAgent.toLowerCase());
  jQuery.browser.webkit = /webkit/.test(navigator.userAgent.toLowerCase());
  jQuery.browser.opera = /opera/.test(navigator.userAgent.toLowerCase());
  jQuery.browser.msie = /msie/.test(navigator.userAgent.toLowerCase());
  
  
  $(window).scroll =>
    if $(window).scrollTop() >= 270
        $("#header-top-fixed").stop(true, true)
        $("#header-top-fixed").fadeIn("slow")
    if $(window).scrollTop() <= 270
        $("#header-top-fixed").stop(true, true)
        $("#header-top-fixed").fadeOut("slow")


  $(".navigation > li").mouseenter ()->
    $a = $(@).find("a")
    newCalss = $($a).attr("hClass")
    $(".navigation > li").attr("class", "")
    $(@).addClass(newCalss)
    $($(@).find(".menu-cont")).fadeIn(120)

  $(".navigation > li").mouseleave ()->
    $($(@).find(".menu-cont")).fadeOut(120)
  
  $(".sub-title").click ()->
    window.location.href = $(@).attr("value")
  
  liNav = $(".menu-cont").find("li")
  
  
  $(".stuff").mouseenter ()->
    $(".fav-menu").show()

  $(".fav-menu").mouseleave ()->
    $(".fav-menu").hide()

  $(".login").mouseenter ()->
    $(".log-menu").show()

  $(".log-menu").mouseleave ()->
    $(".log-menu").hide()




  $(liNav).click ()->
    window.location.href = $(@).attr("value")
  
  
  
  window.nav = {
    face:{
      key   : "face"
      title : "Для лица"
      tip : [
        {
            title : "ВО ВСЕХ КАТЕГОРИЯХ"
            key : ""
        }
        {
          title : "ОЧИЩЕНИЕ"
          key : "face-ochishenie"
          podtip: [
            {
              title : "Для снятия макияжа"
              key : "face-ochishenie1"
            }
            {
              title : "Гидрофильные масла"
              key : "face-ochishenie2"
            }
            {
              title : "Гели для умывания"
              key : "face-ochishenie3"
            }
            {
              title : "Пенки для умывания"
              key : "face-ochishenie4"
            }
            {
              title : "Кремы, пудры для умывания"
              key : "face-ochishenie5"
            }
            {
              title : "Мыло"
              key : "face-ochishenie6"
            }
          ]
        }
      
        {
          title : "ТОНИЗИРОВАНИЕ"
          key : "face-tonizir"
          podtip: [
            {
              title : "Тонеры, стартеры"
              key : "face-tonizir1"
            }
            {
              title : "Мисты (спреи)"
              key : "face-tonizir2"
            }
            {
              title : "Бустеры"
              key : "face-tonizir3"
            }
            {
              title : "Тампоны-патчи"
              key : "face-tonizir4"
            }
          ]
        }
   
        {
          title : "ОСНОВНОЙ УХОД"
          key : "face-osnov-uhod"
          podtip: [
            {
              title : "Ампулы"
              key : "face-osnov-uhod1"
            }
            {
              title : "Сыворотки и эссенции"
              key : "face-osnov-uhod2"
            }
            {
              title : "Лосьоны и эмульсии"
              key : "face-osnov-uhod3"
            }
            {
              title : "Гели"
              key : "face-osnov-uhod4"
            }
            {
              title : "Кремы"
              key : "face-osnov-uhod5"
            }
          ]
        }
      

        {
          title : "СПЕЦИАЛЬНЫЙ УХОД"
          key : "face-spec-uhod"
          podtip: [
            {
              title : "Бальзамы и концентраты"
              key : "face-spec-uhod1"
            }
            {
              title : "Точенчные средства"
              key : "face-spec-uhod2"
            }
            {
              title : "Масла"
              key : "face-spec-uhod3"
            }
            {
              title : "Массажные средства"
              key : "face-spec-uhod4"
            }
          ]
        }

        {
          title : "СОЛНЦЕЗАЩИТНЫЕ СРЕДСТВА"
          key : "face-sonlce-zach"
          podtip: []
        }

        {
          title : "ОТШЕЛУШИВАНИЕ"
          key : "face-otchelush"
          podtip: [
            {
              title : "Скрабы и гаммажи"
              key : "face-otchelush1"
            }
            {
              title : "Пилинги"
              key : "face-otchelush2"
            }
          ]
        }


        {
          title : "МАСКИ"
          key : "face-mask"
          podtip: [
            {
              title : "Ночные маски"
              key : "face-mask1"
            }
            {
              title : "Маски: посты, кремы, пенки"
              key : "face-mask2"
            }
            {
              title : "Тканевые, листовые маски"
              key : "face-mask3"
            }
            {
              title : "Точенчные маски-патчи"
              key : "face-mask4"
            }
          ]
        }
      ]
      dop : [
        {
          title : "Тип кожи"
          key   : "kozha"
          list  : [
            {
              title : "Для всех типов кожи"
              key   : "face-kozha-all"
            }
            {
              title : "Нормальная"
              key   : "face-kozha-norm"
            }
            {
              title : "Жирная/комбинированная"
              key   : "face-kozha-zhir"
            }
            {
              title : "Сухая/очень сухая"
              key   : "face-kozha-suh"
            }
            {
              title : "Проблемная"
              key   : "face-kozha-prob"
            }
            {
              title : "Чувствительная"
              key   : "face-kozha-chuv"
            } 
          ]
        }
        {
          title : "Несовершенства"
          key   : "nesovershenstva"
          list  : [
            {
              title : "Нет несовершенств"
              key   : "face-nes-net"
            }
            {
              title : "Лечение акне и постакне"
              key   : "face-nes-akne"
            }
            {
              title : "Против черных точек"
              key   : "face-nes-cher"
            }
            {
              title : "Сужение пор"
              key   : "face-nes-suzh"
            }
            {
              title : "Отбеливание"
              key   : "face-nes-otb"
            }
            {
              title : "Разглаживание морщин"
              key   : "face-nes-morch"
            } 
            {
              title : "Лифтинг"
              key   : "face-nes-lif"
            } 
            {
              title : "Сухость, шелушение"
              key   : "face-nes-suh"
            } 
            {
              title : "Усталость, тусклый цвет лица"
              key   : "face-nes-ust"
            } 
          ]
        }
      ]
    }

    body:{
      title : "Для тела"
      key   : "body"
      tip:[
        {
            title : "ВО ВСЕХ КАТЕГОРИЯХ"
            key : ""
        }
        {
          title : "УХОД ЗА ТЕЛОМ"
          key : "body-body"
          podtip: [
            {
              title : "Для ванны и душа"
              key : "body-body1"
            }
            {
              title : "Лосьены, кремы и бальзамы"
              key : "body-body2"
            }
            {
              title : "Спреи"
              key : "body-body3"
            }
            {
              title : "Масла"
              key : "body-body4"
            }
            {
              title : "Массажные средства"
              key : "body-body5"
            }
            {
              title : "Скрабы"
              key : "body-body6"
            }
          ]
        }
        
        
        {
          title : "УХОД ЗА РУКАМИ"
          key : "body-hend"
          podtip: [
            {
              title : "Кремы и лосьоны"
              key : "body-hend1"
            }
            {
              title : "Маски и скрабы"
              key : "body-hend2"
            }
            {
              title : "Уход за ногтями"
              key : "body-hend3"
            }
          ]
        }
        
        
        {
          title : "УХОД ЗА НОГАМИ"
          key : "body-footer"
          podtip: [
            {
              title : "Скрабы и пилинги"
              key : "body-footer1"
            }
            {
              title : "Маски и патчи"
              key : "body-footer2"
            }
            {
              title : "Лосьоны, кремы, спреи"
              key : "body-footer3"
            }
            {
              title : "Дезодорирующие средства"
              key : "body-footer4"
            }
          ]
        }
        
        {
          title : "ДЛЯ СТРОЙНОГО СИЛУЭТА"
          key : "body-stroin"
          podtip: [
            {
              title : "Гели, кремы и скрабы"
              key : "body-stroin1"
            }
            {
              title : "Маски и патчи"
              key : "body-stroin2"
            }
          ]
        }
        
        {
          title : "ЭПИЛЯЦИЯ, ДЕПИЛЯЦИЯ"
          key : "body-epil"
          podtip: []
        }
        
        {
          title : "ПАРФЮМИРОВАННЫЕ И 
ДЕЗОДОРИРУЮЩИЕ СРЕДСТВА"
          key : "body-porf"
          podtip: []
        }
        
        
        {
          title : "СОЛНЦЕЗАЩИТНЫЕ СРЕДСТВА"
          key : "body-solnc"
          podtip: []
        }
      ]
      
      
      dop : [
        {
          title : "Несовершенства"
          key : "nesovershenstva"
          list : [
            {
              title : "Нет несовершенств"
              key   : "body-nes-net"
            }
            {
              title : "Против сухости кожи"
              key   : "body-nes-suh"
            }
            {
              title : "Против усталости"
              key   : "body-nes-ust"
            }
            {
              title : "Против морщин и потери упругости"
              key   : "body-nes-morch"
            }
            {
              title : "Отбеливающие средства"
              key   : "body-nes-otb"
            }
          ]
        }
      ]
    }


    makeup:{
        title : "Макияж"
        key   : "makeup"
        tip:[
            {
                title : "ВО ВСЕХ КАТЕГОРИЯХ"
                key : ""
            }
            {
              title : "ЛИЦО"
              key : "makeup-face"
              podtip: [
                    {
                      title : "Базы под макияж"
                      key : "makeup-face1"
                    }
                    {
                      title : "ВВ-кремы"
                      key : "makeup-face2"
                    }
                    {
                      title : "CC-кремы"
                      key : "makeup-face3"
                    }
                    {
                      title : "Крем-пудры, бальзамы"
                      key : "makeup-face4"
                    }
                    {
                      title : "Пудры сухие"
                      key : "makeup-face5"
                    }
                    {
                      title : "Консилеры/корректоры"
                      key : "makeup-face6"
                    }
                    {
                      title : "Хайлайтеры и бронзеры"
                      key : "makeup-face7"
                    }
                    {
                      title : "Румяна"
                      key : "makeup-face8"
                    }
                    {
                      title : "Фиксаторы макияжа"
                      key : "makeup-face9"
                    }

              ]
            }
            {
                title : "ГЛАЗА"
                key : "makeup-eyes"
                podtip: [
                    {
                      title : "Базы под тушь, фиксаторы"
                      key : "makeup-eyes1"
                    }
                    {
                      title : "Туши"
                      key : "makeup-eyes2"
                    }
                    {
                      title : "Базы под тени"
                      key : "makeup-eyes3"
                    }
                    {
                      title : "Тени для век"
                      key : "makeup-eyes4"
                    }
                    {
                      title : "Карандаши для глаз"
                      key : "makeup-eyes5"
                    }
                    {
                      title : "Подводки"
                      key : "makeup-eyes6"
                    }
                ]
            }
            
            {
                title : "ГУБЫ"
                key : "makeup-lips"
                podtip: [
                    {
                      title : "Базы под макияж губ"
                      key : "makeup-lips1"
                    }
                    {
                      title : "Тинты"
                      key : "makeup-lips2"
                    }
                    {
                      title : "Блески"
                      key : "makeup-lips3"
                    }
                    {
                      title : "Помады"
                      key : "makeup-lips4"
                    }
                ]
            }
        ]
    }
    
    
    forman:{
        title : "Для мужчин"
        key   : "forman"
        tip:[
            {
                title : "ВО ВСЕХ КАТЕГОРИЯХ"
                key : ""
            }
            {
              title : "БАЗОВЫЙ УХОД"
              key : "forman-baza"
              podtip: [
                    {
                      title : "Пенки, гели для умывания"
                      key : "forman-baza1"
                    }
                    {
                      title : "Скрабы"
                      key : "forman-baza2"
                    }
                    {
                      title : "Тонеры"
                      key : "forman-baza3"
                    }
                    {
                      title : "Спреи (мисты)"
                      key : "forman-baza4"
                    }
                    {
                      title : "Лосьоны, эмульсии, кремы"
                      key : "forman-baza5"
                    }
                    {
                      title : "Бальзамы для губ"
                      key : "forman-baza6"
                    }
                    {
                      title : "Листовые маски"
                      key : "forman-baza7"
                    }
              ]
            }
            {
                title : "ДЛЯ ТЕЛА И ВОЛОС"
                key : "forman-body"
                
            }
            {
                title : "ПАРФЮМИРОВАННЫЕ СРЕДСТВА"
                key : "forman-porf"
            }
            {
                title : "ПОСЛЕ БРИТЬЯ"
                key : "forman-brit"
            }
            {
                title : "МУЖСКИЕ ВВ-КРЕМЫ"
                key : "forman-bbkrem"
            }
        ]
        dop : [
            {
                title : "Тип кожи"
                key   : "kozha"
            list  : [
                {
                    title : "Для всех типов кожи"
                    key   : "forman-kozha-all"
                }
                {
                    title : "Нормальная"
                    key   : "forman-kozha-norm"
                }
                {
                    title : "Жирная/комбинированная"
                    key   : "forman-kozha-zhir"
                }
                {
                    title : "Сухая/очень сухая"
                    key   : "forman-kozha-suh"
                }
                {
                    title : "Cклонная к воспалениям"
                    key   : "forman-kozha-vosp"
                }
                {
                    title : "Чувствительная"
                    key   : "forman-kozha-chuv"
                } 
            ]
            }
        ]
    }


    set:{
        title : "Наборы"
        key   : "set"
        tip:[
            {
                title : "ВО ВСЕХ КАТЕГОРИЯХ"
                key : ""
            }
            {
              title : "НАБОРЫ"
              key : "set-set"
              podtip: [
                    {
                      title : "Уход за лицом"
                      key : "set-set1"
                    }
                    {
                      title : "Уход за телом"
                      key : "set-set2"
                    }
                    {
                      title : "Уход за волосами"
                      key : "set-set3"
                    }
                    {
                      title : "Для мужчин"
                      key : "set-set4"
                    }
                    {
                      title : "Макияж"
                      key : "set-set5"
                    }
                    {
                      title : "Маникюр"
                      key : "set-set6"
                    }
              ]
            }
            {
                title : "СЭМПЛ-НАБОРЫ"
                key : "set-semple"
            }
        ]
    }

    access:{
        title : "Аксессуары"
        key   : "access" 
        tip:[
            {
                title : "ВО ВСЕХ КАТЕГОРИЯХ"
                key : ""
            }
            {
              title : "ДЛЯ ОЧИЩЕНИЯ КОЖИ"
              key : "access-ochish"
              podtip: [
                    {
                      title : "Щеточки, губки"
                      key : "access-ochish1"
                    }
                    {
                      title : "Спонжи конняку"
                      key : "access-ochish2"
                    }
                    {
                      title : "Хлопковые тампоны и диски"
                      key : "access-ochish3"
                    }
                    {
                      title : "Прочее"
                      key : "access-ochish4"
                    }
              ]
            }
            {
                title : "ДЛЯ МАСОК"
                key : "access-mask"
            }
            {
                title : "ДЛЯ МАССАЖА"
                key : "access-massazh"
            }
            
            {
              title : "ДЛЯ МАКИЯЖА"
              key : "access-makeup"
              podtip: [
                    {
                      title : "Кисти для макияжа"
                      key : "access-makeup1"
                    }
                    {
                      title : "Пуховки, спонжи"
                      key : "access-makeup2"
                    }
                    {
                      title : "Матирующие салфетки"
                      key : "access-makeup3"
                    }
                    {
                      title : "Очищающие средства для спонжей и кистей"
                      key : "access-makeup4"
                    }
              ]
            }
            {
                title : "ДЛЯ ВОЛОС"
                key : "access-header"
            }
            {
                title : "ДЛЯ МАНИКЮРА И ПЕДИКЮРА"
                key : "access-manikur"
            }
            {
                title : "РАЗНОЕ"
                key : "access-raznoe"
            }
        ]
    }
  }
  
  
