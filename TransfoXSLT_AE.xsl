<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs tei"
    version="2.0">
    
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    
    <!-- Template des pages HTML -->
    
    <xsl:template match="/">
        
        <!-- Déclaration de variables pour appeler les pages HTML -->
        <xsl:variable name="index_personnages">
            <xsl:text>index_personnages.html</xsl:text>
        </xsl:variable>
        <xsl:variable name="index_lieux">
            <xsl:text>index_lieux.html</xsl:text>
        </xsl:variable>
        <xsl:variable name="accueil">
            <xsl:text>accueil.html</xsl:text>
        </xsl:variable>
        
        <!-- Déclaration de variables pour appeler divers éléments -->
        
        <!-- Pour appeler le titre du roman (Le tour du Monde..)-->
        <xsl:variable name="titre">
            <xsl:value-of select="//sourceDesc/biblFull/titleStmt/title"/>
        </xsl:variable>
        
        <!-- Pour appeler le nom de l'auteur du texte encodé (Jules V)-->
        <xsl:variable name="JV">
            <xsl:value-of
                select="concat(//fileDesc/titleStmt//forename, ' ', //fileDesc/titleStmt//surname)" />
        </xsl:variable>
        
        <!-- Pour appeler le nom de la responsable de l'encodage -->
        <xsl:variable name="AE">
            <xsl:value-of select="concat(//respStmt//forename, ' ', //respStmt//surname)"/>
        </xsl:variable>
        
        <!-- Pour appeler la description de l'édition numérique XML-TEI -->
        <xsl:variable name="edition_numerique">
            <xsl:value-of select="//editionStmt/edition"/>
        </xsl:variable>
        
        <!-- Pour appeler la description de l'encodage XML-TEI j'ai 2 paragraphes-->
        <xsl:variable name="description">
            <xsl:value-of select="//encodingDesc/p"/>
        </xsl:variable>
        
        <!-- Pour appeler le nom de l'éditeur -->
        <xsl:variable name="editeur">
            <xsl:value-of select="//biblFull/publicationStmt/publisher"/>
        </xsl:variable>
        
        <!-- Pour appeler l'adresse de l'éditeur -->
        <xsl:variable name="editeur_adresse">
            <xsl:value-of
                select="concat(', ', //biblFull/descendant::address/street, ', ', //biblFull/descendant::address/settlement)"
            />
        </xsl:variable>
        
        <!-- Pour appeler la date de publication -->
        <xsl:variable name="date_publication">
            <xsl:value-of select="//sourceDesc//date"/>
        </xsl:variable>
        
        <!-- Pour appeler la BNF -->
        <xsl:variable name="bnf">
            <xsl:value-of select="//publicationStmt/distributor"/>
        </xsl:variable>
        
        <!-- Pour appeler le lien vers Gallica -->
        <xsl:variable name="facsimile">
            <xsl:value-of select="//biblFull/publicationStmt/distributor/@facs"/>
        </xsl:variable>
        
        <!-- Pour appeler la licence liée à la BNF -->
        <xsl:variable name="bnf_licence">
            <xsl:value-of select="concat(', ', //sourceDesc//availability)"/>
        </xsl:variable>
        
        <!--<!-\- Pour appeler le titre du roman-feuilleton -\->
        <xsl:variable name="titre_roman-feuilleton">
            <xsl:value-of select="//seriesStmt/biblScope[@unit = 'book']"/>
        </xsl:variable>-->
        
        <!-- Pour appeler le titre du chapitre -->
        <xsl:variable name="chapitre">
            <xsl:value-of select="//seriesStmt/title"/>
        </xsl:variable>
        
        <!-- Pour appeler la page du journal -->
        <xsl:variable name="page">
            <xsl:value-of select="//seriesStmt/biblScope[@unit = 'page']"/>
        </xsl:variable>
        
        
        <!-- Sortie de la page d'accueil -->
        <xsl:result-document href="pages/{$accueil}" method="html" indent="yes">
            <html>
                <head>
                    <!-- Appel du template head HTML -->
                    <xsl:call-template name="head"/>
                    <title>
                        <xsl:value-of select="concat($titre, ' | ', 'Accueil')"/>
                    </title>
                </head>
                
                <body>
                    <!-- Appel du template barre de navigation -->
                    <xsl:call-template name="navbar"/>
                    
                    <div type="container">
                        <h1 class="text-center">
                            <xsl:value-of
                                select="concat('Encodage XML-TEI d''un extrait de ', $titre, ' de ', $JV)"
                            />
                        </h1>
                        <div class="text-center" style="display: block; ">
                            <!-- Intégration du journal numérisé via Gallica -->
                            <iframe style="width:910px; height: 650px; border: 0;"
                                src="https://gallica.bnf.fr/ark:/12148/bpt6k2251979/f1.item"/>
                        </div>
                        <p class="text-center"><i>Le tour du monde en quatre-vingts jours</i> est un
                            roman-feuilleton écrit par Jules Verne est publié pour la première fois 
                            du 6 novembre au 22 décembre 1872 dans le feuilleton du journal 
                            <i><xsl:value-of select="$editeur"/></i>, 
                            avec des interruptions régulières.
                             L'encodage porte sur le chapitre XIV, paru dans le numéro du
                            <xsl:value-of select="$date_publication"/>. <xsl:value-of
                                select="$description"/></p>
                        <div>
                            <h2>Source de l'encodage :</h2>
                            <ul>
                                <li>
                                    <b>Titre du roman : </b>
                                    <xsl:value-of select="$titre"/>
                                </li>
                                <li>
                                    <b>Chapitre : </b>
                                    <xsl:value-of select="$chapitre"/>
                                </li>
                                <li>
                                    <b>Pages : </b>
                                    <xsl:value-of select="$page"/>
                                </li>
                                <li>
                                    <b>Date originale de publication : </b>
                                    <xsl:value-of select="$date_publication"/>
                                </li>
                                <li>
                                    <b>Publié chez : </b>
                                    <i>
                                        <xsl:value-of select="$editeur"/>
                                    </i>
                                    <xsl:value-of select="$editeur_adresse"/>
                                </li>
                                <li>
                                    <b>Facsimilé : </b>
                                    <a href="{$facsimile}">
                                        <xsl:value-of select="$bnf"/>
                                    </a>
                                    <xsl:value-of select="$bnf_licence"/>
                                </li>
                            </ul>
                        </div>
                        <div>
                            <h2>L'encodage :</h2>
                            <p>
                                <xsl:value-of select="/$edition_numerique"/>
                                <a
                                    href="https://github.com/AudeEych/XML-TEI_LeTemps/blob/main/Documentation/ODD_XML-TEI_JVerne.html"
                                    >Voir l'ODD correspondante.</a>
                            </p>
                            <p>Transformation XSL réalisée dans le cadre du cours "Techniques et
                                chaîne de publication électronique" de Mme Ségolène Albouy du Master
                                TNAH de l'Ecole nationale des chartes.</p>
                            <p>La transformation XSL permet de mettre en valeur les lieux et
                                personnages évoqués dans le texte au travers de la constitution
                                d'index.</p>
                        </div>
                        <div class="text-center">
                            <xsl:value-of select="concat($AE, ', 2023')"/>
                            <a class="github"
                                href="https://github.com/AudeEych/Projet_XSLT_Jules_Verne">
                                <img width="28" height="28" src="../images/GitHub-Mark-32px.png"
                                    alt="Voir le projet sur GitHub"
                                    title="Voir le projet sur Github"/>
                            </a>
                        </div>
                    </div>
                </body>
            </html>
        </xsl:result-document>
        
    
    <!-- Sortie de la page d'index des personnages -->
    <xsl:result-document href="pages/{$index_personnages}" method="html" indent="yes">
        <html>
            <head>
                <!-- Appel du head HTML -->
                <xsl:call-template name="head"/>
                <title>
                    <xsl:value-of select="concat($titre, ' | ', 'Personnages')"/>
                </title>
            </head>
            
            <body>
                <!-- Appel de la barre de navigation -->
                <xsl:call-template name="navbar"/>
                <xsl:call-template name="index_personnages"/>
            </body>
        </html>
    </xsl:result-document>
    
    
    <!--<!-\- Sortie de la page d'index des lieux -\->
    <xsl:result-document href="pages/{$index_lieux}" method="html" indent="yes">
        <html>
            <head>
                <!-\- On appelle le head HTML -\->
                <xsl:call-template name="head"/>
                <title>
                    <xsl:value-of select="concat($titre, ' | ', 'Lieux')"/>
                </title>
            </head>
            
            <body>
                <!-\- On appelle la barre de navigation -\->
                <xsl:call-template name="navbar"/>
                <xsl:call-template name="index_lieux"/>
            </body>
        </html>
    </xsl:result-document>-->
    
    </xsl:template>
    
    
    
    
        
        <!-- Template de l'élément head du HTML -->
        
        <xsl:template name="head">
            
            <!-- Métadonnées du document -->
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
            <meta name="description"
                content="Édition numérique de la fin du chapitre XIV du roman Le tour du monde en quatre-vingts jours de Jules Verne"/>
            <meta name="keywords" content="XML, TEI, XSLT"/>
            <meta name="author" content="Aude Eychenne"/>
            
            <!-- Références Bootstrap -->
            <link rel="stylesheet"
                href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
                integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
                crossorigin="anonymous"/>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"/>
            
            <!-- Ajouter une icône aux onglets du navigateur -->
            <link rel="icon" type="image/png" href="../images/favicon.png"/>
            
            <style type="text/css">
                /* Centrer le contenu des pages et justifier le texte */
                div[type = "container"] {
                margin-top: 50px;
                margin-bottom: 100px;
                margin-left: 100px;
                margin-right: 100px;
                text-align: justify;
                }
                
                /* Pour insérer un espace après les titres h1 */
                h1 {
                margin-bottom: 50px;
                }
                
                /* Pour insérer un espace après les titres h2 */
                h2 {
                margin-bottom: 30px;
                }
                
                /* Pour insérer des espaces avant et après les div */
                div {
                margin-top: 50px;
                margin-bottom: 50px;
                }
                
                /* Décaler à droite le logo GitHub localisé en bas de la page d'accueil */
                .github {
                margin-left: 8px;
                }
                
                /* Mise en forme des éléments du tableau */
                td {
                padding: 15px;
                text-align: justify;
                }
                
                /* Mise en forme des cartes */
                div.card {
                padding: 15px;
                margin: 20px;
                }
                
                /* Créer un effet au survol de la carte */
                .card:hover {
                transform: scale(1.05);
                box-shadow: 0 10px 20px rgba(0, 0, 0, .12), 0 4px 8px rgba(0, 0, 0, .06);
                }</style>
            
        </xsl:template>
        
        <!-- Template de la barre de navigation -->
        
        <xsl:template name="navbar">
            
            <!-- Variables pour appeler les pages html -->
            <xsl:variable name="index_personnages">
                <xsl:text>index_personnages.html</xsl:text>
            </xsl:variable>
            <xsl:variable name="index_lieux">
                <xsl:text>index_lieux.html</xsl:text>
            </xsl:variable>
            <xsl:variable name="accueil">
                <xsl:text>accueil.html</xsl:text>
            </xsl:variable>
            
            <!-- Création de la barre de navigation et de ses onglets -->
            <nav class="navbar navbar-expand-md navbar-dark justify-content-between"
                style="background-color: #003844;">
                <a class="navbar-brand" href="{$accueil}"><img src="../images/favicon_rond.png"
                    alt="Le tour du monde en quatre-vingts jours" height="30"/> Accueil</a>
                <ul class="navbar-nav mr-auto">
                    
                    <li class="nav-item">
                        <a class="nav-link" href="{$index_personnages}">Index des personnages</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{$index_lieux}">Index des lieux</a>
                    </li>
                </ul>
            </nav>
            
        </xsl:template>
    
    <!-- Templates supplémentaires nommés -->
    
    <!-- Créer un tableau permettant d'afficher les lignes et leur numérotation -->
    <xsl:template match="//body//p/cb/lb" mode="#all">
        <table>
            <tbody>
                <tr>
                    <td>
                        <i>
                            <xsl:value-of select="./@n"/>
                        </i>
                    </td>
                    <td>
                        <xsl:apply-templates mode="#current"/>
                    </td>
                </tr>
            </tbody>
        </table>
    </xsl:template>
    
    
    <!-- Créer un renvoi vers l'index des personnages pour les mentions de personnages -->
    <xsl:template match="//body//persName" mode="#all">
        <xsl:variable name="index_personnages">
            <xsl:text>index_personnages.html</xsl:text>
        </xsl:variable>
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="$index_personnages"/>
            </xsl:attribute>
            <xsl:apply-templates mode="#current"/>
        </xsl:element>
    </xsl:template>
        
    <!-- Rendre compte des caractères en italique -->
    <xsl:template match="//body//emph" mode="#all">
        <i>
            <xsl:apply-templates mode="#current"/>
        </i>
    </xsl:template>
        
        <!-- Templates supplémentaires nommés -->
        
        <!-- Index des personnages -->
        <xsl:template name="index_personnages">
            <div type="container">
                <h1 class="text-center"> Index des personnages </h1>
                
                <div class="text-center">
                    <i>N.B. : § signifie "paragraphe".</i>
                </div>
                
                <div class="col-sm">
                    <xsl:for-each select="//listPerson/person">
                        <!-- On trie les personnages par ordre alphabétique -->
                        <xsl:sort select="./persName[1]" order="ascending"/>
                        <div class="card">
                            <h4 class="card-title">
                                <xsl:value-of select="./persName[1]"/>
                            </h4>
                            
                            <!-- On renseigne le sexe du personnage -->
                            <p class="card-text">
                                <xsl:if test="./sex/@value = 'M'">
                                    <xsl:text>Sexe : masculin</xsl:text>
                                </xsl:if>
                                <xsl:if test="./sex/@value = 'F'">
                                    <xsl:text>Sexe : féminin</xsl:text>
                                </xsl:if>
                                <xsl:if test="./sex/@value = 'O'">
                                    <xsl:text>Sexe : indéterminé</xsl:text>
                                </xsl:if>
                                <br/>
                                <br/>
                                
                                <!-- Afficher la catégorie du personnage -->
                                <p class="card-text">
                                    <xsl:if test="//listPerson/@type='fictional'">
                                        <xsl:text>Personnages de fiction propre au récit</xsl:text>
                                    </xsl:if>
                                    <xsl:if test="//listPerson/@type='mythic'">
                                        <xsl:text>Figures divines</xsl:text>
                                    </xsl:if>
                                    <xsl:if test="//listPerson/@type='real'">
                                        <xsl:text>Personnage réels</xsl:text>
                                    </xsl:if>
                                    <br/>
                                    <br/>
                               
                                
                                <!-- On inclut une brève description du personnage -->
                                <i>
                                    <xsl:value-of select="./note"/>
                                </i>
                                <br/>
                                <br/>
                                
                                <!-- Variable pour stocker l'id d'un personnage -->
                                <xsl:variable name="idPerson">
                                    <xsl:value-of select="./@xml:id"/>
                                </xsl:variable>
                                <xsl:if test="./sex/@value = 'M'">
                                    <b>Evoqué au(x) § : </b>
                                </xsl:if>
                                <xsl:if test="./sex/@value = 'F'">
                                    <b>Evoquée au(x) § : </b>
                                </xsl:if>
                                    <xsl:if test="./sex/@value = 'O'">
                                        <b>Evoqué au(x) § : </b>
                                    </xsl:if>
                                    
                                    <!-- Recherche des paragraphes où sont mentionnés les personnages (soit directement, via la balise persName, soit indirectement, via la balise rs) -->
                                    <xsl:for-each
                                        select="ancestor::TEI//body/div/p//persName[replace(@ref, '#', '') = $idPerson] | ancestor::TEI//body/div/p//rs[replace(@ref, '#', '') = $idPerson]">
                                        <b>
                                            <xsl:value-of select="ancestor::p/@n"/>
                                        </b>
                                        <!-- Rendre compte de la référence dans le texte -->
                                        <xsl:text> (</xsl:text>
                                        <xsl:value-of select=".//text()"/>
                                        <xsl:text>) </xsl:text>
                                        <xsl:choose>
                                            <xsl:when test="position() != last()">, </xsl:when>
                                            <xsl:otherwise>.</xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:for-each>
                                    <br/>
                                    <br/>
                                    <!-- Compte du nombre de mentions directes et indirectes d'un personnage -->
                                    <b>
                                        <xsl:text>Soit : </xsl:text>
                                        <xsl:value-of
                                            select="count(ancestor::TEI//body//persName[replace(@ref, '#', '') = $idPerson] | ancestor::TEI//body/div/p//rs[replace(@ref, '#', '') = $idPerson])"/>
                                        <xsl:text> mention(s).</xsl:text>
                                    </b>
                                    <br/>
                                    
                                    <!-- On recherche les paragraphes où chaque personnage prend la parole -->
                                    <xsl:if
                                        test="ancestor::TEI//body/div/p//said[replace(@who, '#', '') = $idPerson]">
                                        <br/>
                                        <br/>
                                        <b>Prend la parole au(x) § : </b>
                                        <xsl:for-each
                                            select="ancestor::TEI//body/div/p//said[replace(@who, '#', '') = $idPerson]">
                                            <b>
                                                <xsl:value-of select="ancestor::p/@n"/>
                                            </b>
                                            <xsl:choose>
                                                <xsl:when test="position() != last()">, </xsl:when>
                                                <xsl:otherwise>.</xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:for-each>
                                        <br/>
                                        <br/>
                                        
                                        <!-- Compte du nombre de prises de parole d'un personnage -->
                                        <b>
                                            <xsl:text>Soit : </xsl:text>
                                            <xsl:value-of
                                                select="count(ancestor::TEI//body/div/p//said[replace(@who, '#', '') = $idPerson])"/>
                                            <xsl:text> prise(s) de parole.</xsl:text>
                                        </b>
                                    </xsl:if>
                            </p>
                            </p>
                        </div>
                    </xsl:for-each>
                </div>
            </div>
        </xsl:template>
    
        
</xsl:stylesheet>