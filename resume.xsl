<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" indent="yes"/>

  <xsl:key name="skill-by-category" match="skill" use="category" />

  <xsl:template match="/">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="resume">
    <div class="page">
      <div class="left-rail">
        <!-- photo -->
        <div class="profile">
          <img class="profile-photo" src="../images/profile.jfif" alt="Chris Pearson" />
        </div>

        <!-- info -->
        <div class="info">
          <h2>Info</h2>
          <xsl:apply-templates select="person"/>
        </div>

        <!-- certifications -->
        <div class="certifications">
          <h2>Certifications</h2>
          <xsl:apply-templates select="certification"/>
        </div>

        <!-- skills -->
        <div class="skills">
          <h2>Skills</h2>
          <xsl:for-each select="skill[generate-id() = generate-id(key('skill-by-category', category)[1])]">
            <xsl:sort select="category" />
            <div class="skill-category clearfix">
              <div><h3>
                <xsl:value-of select="category" />
              </h3></div>
              <xsl:for-each select="key('skill-by-category', category)">
                <!-- <xsl:sort select="@name" /> -->
                <div class="skill">
                  <xsl:value-of select="@name" />
                </div>
              </xsl:for-each>
            </div>
          </xsl:for-each>
        </div>

      </div>
      <div class="main">

        <!-- name and title -->
        <div class="heading">
          <div class="person-name"><h1><xsl:value-of select="person/@name"/></h1></div>
          <div class="person-title"><xsl:value-of select="person/@title"/></div>
        </div>

        <!-- experience -->
        <div class="section-heading clearfix">
          <div class="icon">
            <i class="fas fa-briefcase"></i>
          </div>
          <div class="section-heading-title">
            <h2>Experience</h2>
          </div>
        </div>
        <div class="job-history">
          <xsl:apply-templates select="job"/>
        </div>

      <!-- education -->
      <div class="section-heading clearfix">
        <div class="icon">
          <i class="fas fa-graduation-cap"></i>
        </div>
        <div class="section-heading-title">
          <h2>Education</h2>
        </div>
      </div>
      <div class="job-history">
        <xsl:apply-templates select="degree"/>
      </div>
    </div>


    </div>
  </xsl:template>

  <xsl:template match="person">
      <!-- contact details -->
      <div class="contacts">
        <xsl:apply-templates select="address" mode="full"/>
        <xsl:apply-templates select="contacts/contact" />
      </div>
  </xsl:template>

  <xsl:template match="address" mode="short">
    <xsl:variable name="addr">
      <xsl:value-of select="city"/>
      <xsl:text>, </xsl:text>
      <xsl:value-of select="state"/>
    </xsl:variable>
    <div class="contact clearfix">
      <span class="icon">
        <i class="fas fa-map-marker-alt"></i>
      </span>
      <span>
        <xsl:value-of select="normalize-space($addr)"/>
      </span>
    </div>
  </xsl:template>

  <xsl:template match="address" mode="full">
    <xsl:variable name="addr">
      <xsl:value-of select="line"/>
      <xsl:text>, </xsl:text>
      <xsl:value-of select="city"/>
      <xsl:text>, </xsl:text>
      <xsl:value-of select="state"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="zip"/>
    </xsl:variable>
    <div class="contact clearfix">
      <span class="icon"><i class="fas fa-map-marker-alt"></i></span>
      <span class="contact-details">
        <xsl:value-of select="normalize-space($addr)"/>
      </span>
    </div>
  </xsl:template>

  <xsl:template match="contact">
    <div class="contact clearfix">
        <xsl:choose>
          <xsl:when test="@type = 'github'">
            <span class="icon">
              <i class="fab fa-github"></i>
            </span>
            <span class="contact-details">
              <a>
                <xsl:attribute name="target">_blank</xsl:attribute>
                <xsl:attribute name="href">https://github.com/<xsl:value-of select="." />?tab=repositories</xsl:attribute>
                <xsl:value-of select="."/>
              </a>
            </span>
          </xsl:when>

          <xsl:when test="@type = 'linkedin'">
            <span class="icon">
              <i class="fab fa-linkedin"></i>
            </span>
            <span>
              <a>
                <xsl:attribute name="target">_blank</xsl:attribute>
                <xsl:attribute name="href">https://www.linkedin.com/in/<xsl:value-of select="." /></xsl:attribute>
                <xsl:value-of select="."/>
              </a>
            </span>
          </xsl:when>

          <xsl:when test="@type = 'phone'">
            <span class="icon">
              <i class="fas fa-phone"></i>
            </span>
            <span>
              <xsl:value-of select="."/>
            </span>
          </xsl:when>

          <xsl:when test="@type = 'email'">
            <span class="icon">
              <i class="fas fa-envelope"></i>
            </span>
            <span>
              <a>
                <xsl:attribute name="href">mailto:<xsl:value-of select="." /></xsl:attribute>
                <xsl:value-of select="."/>
              </a>
            </span>
          </xsl:when>

          <xsl:when test="@type = 'www'">
            <span class="icon">
              <i class="fas fa-globe"></i>
            </span>
            <span>
              <a>
                <xsl:attribute name="target">_blank</xsl:attribute>
                <xsl:attribute name="href">http://<xsl:value-of select="." /></xsl:attribute>
                <xsl:value-of select="."/>
              </a>
            </span>
          </xsl:when>

          <xsl:otherwise>
            <span></span>
            <span>
              <xsl:value-of select="."/>
            </span>
          </xsl:otherwise>

        </xsl:choose>
    </div>
  </xsl:template>

  <xsl:template match="certification">
    <div class="certification">
      <div>
        <a>
          <xsl:attribute name="target">_blank</xsl:attribute>
          <xsl:attribute name="href">
            <xsl:value-of select="badge/url" disable-output-escaping="true"/>
          </xsl:attribute>

          <img>
            <xsl:attribute name="class">badgr-icon</xsl:attribute>
            <xsl:attribute name="src">
              <xsl:value-of select="badge/icon" disable-output-escaping="true"/>
            </xsl:attribute>
            <xsl:attribute name="alt">
              <xsl:value-of select="@name"/>
            </xsl:attribute>
          </img>
        </a>
      </div>
      <div class="cert-info">
        <span>
          <xsl:value-of select="@name"/>
        </span>
        <span>
          <xsl:value-of select="issuer/@name"/>
        </span>
        <span>
          <xsl:apply-templates select="period" mode="short" />
        </span>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="period" mode="full">
    <div class="date">
      <span>
        <xsl:value-of select="from/@month"/>
        <xsl:text>/</xsl:text>
        <xsl:value-of select="from/@year"/>
      </span>
      <span>
        <xsl:choose>
          <xsl:when test="not(to)">present</xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="to/@month"/>
            <xsl:text>/</xsl:text>
            <xsl:value-of select="to/@year"/>
          </xsl:otherwise>
        </xsl:choose>
      </span>
    </div>
  </xsl:template>

  <xsl:template match="period" mode="short">
    <div class="date">
      <span>
        <xsl:value-of select="to/@month"/>
        <xsl:text>/</xsl:text>
        <xsl:value-of select="to/@year"/>
      </span>
    </div>
  </xsl:template>

  <xsl:template match="job">
    <div class="job">
      <div class="job-heading clearfix">
        <div class="icon">
          <i class="far fa-circle"></i>
        </div>

        <xsl:apply-templates select="period" mode="full"/>

        <div class="title">
          <h3>
            <xsl:value-of select="@title"/>
          </h3>
        </div>
      </div>

      <div class="company-location clearfix">
        <div class="company">
          <xsl:value-of select="employer/@name"/>
        </div>

        <xsl:apply-templates select="employer/address" mode="short"/>

      </div>

      <div class="accomplishments">
        <ul>
          <xsl:for-each select="duties/duty">
            <li>
              <xsl:value-of select="."/>
            </li>
          </xsl:for-each>
        </ul>
      </div>

    </div>
  </xsl:template>

  <xsl:template match="degree">
    <div class="job">
      <div class="job-heading clearfix">
        <div class="icon">
          <i class="far fa-circle"></i>
        </div>

        <xsl:apply-templates select="period" mode="short"/>

        <div class="title">
          <h3>
            <xsl:value-of select="@name"/>
          </h3>
        </div>
      </div>

      <div class="company-location clearfix">
        <div class="company">
          <xsl:value-of select="institution/@name"/>
        </div>

        <xsl:apply-templates select="institution/address" mode="short"/>

      </div>

      <div class="accomplishments">
        <ul>
          <xsl:for-each select="major">
            <li>
              <xsl:value-of select="."/>
            </li>
          </xsl:for-each>
        </ul>
      </div>

    </div>
  </xsl:template>

</xsl:stylesheet>
