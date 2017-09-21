require "rexml/document"

# source = "\n                                    <table>\n                                                                                    <tbody><tr class=\"\">\n                                                <th>Цвет ножек:</th>\n                                                <td>натуральный</td>\n                                            </tr>\n                                                                                    <tr class=\"\">\n                                                <th>Размер (Ш х Г х В):</th>\n                                                <td>460 х 530 х 800 мм</td>\n                                            </tr>\n                                                                                    <tr class=\"\">\n                                                <th>Материал седла:</th>\n                                                <td>полипропилен</td>\n                                            </tr>\n                                                                                    <tr class=\"\">\n                                                <th>Материал ножек:</th>\n                                                <td>массив бука; сталь</td>\n                                            </tr>\n                                                                                    <tr class=\"\">\n                                                <th>Страна происхождения:</th>\n                                                <td>Китай</td>\n                                            </tr>\n                                                                                    <tr class=\"\">\n                                                <th>Максимальная нагрузка:</th>\n                                                <td>140 кг</td>\n                                            </tr>\n                                                                                    <tr class=\"\">\n                                                <th>Высота до сиденья:</th>\n                                                <td>450 мм</td>\n                                            </tr>\n                                                                                    <tr class=\"\">\n                                                <th>Вес:</th>\n                                                <td>3,3 кг</td>\n                                            </tr>\n                                                                            </tbody></table>\n                                                                            <div class=\"scheme\">\n                                            <img src=\"/upload/iblock/922/chairs_final_01.png\" alt=\"\">\n                                        </div>\n                                                                    "

source = "<table><tbody><tr class=''><th>Цвет ножек:</th><td>натуральный</td></tr><tr class=''><th>Размер (Ш х Г х В):</th><td>460 х 530 х 800 мм</td></tr><tr class=''><th>Материал седла:</th><td>полипропилен</td></tr><tr class=''><th>Материал ножек:</th><td>массив бука; сталь</td></tr><tr class=''><th>Страна происхождения:</th><td>Китай</td></tr><tr class=''><th>Максимальная нагрузка:</th><td>140 кг</td></tr><tr class=''><th>Высота до сиденья:</th><td>450 мм</td></tr><tr class=''><th>Вес:</th><td>3,3 кг</td></tr></tbody></table><div class='scheme'><img src='/upload/iblock/922/chairs_final_01.png' alt=''></div>"

source = source
.gsub('\n','')
.gsub('/[^[:print:]]/', '')
.gsub(/\n/, '')
.gsub('  ', '')
.gsub(/\"/, "'")
# .gsub('\"', '\'')

p source

doc = REXML::Document.new(source)
formatter = REXML::Formatters::Pretty.new

# Compact uses as little whitespace as possible
formatter.compact = true
formatter.write(doc, $stdout)
