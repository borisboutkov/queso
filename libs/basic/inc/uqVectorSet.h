/* uq/libs/queso/inc/uqVectorSet.h
 *
 * Copyright (C) 2008 The QUESO Team, http://queso.ices.utexas.edu/
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or (at
 * your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 */

#ifndef __UQ_VECTOR_SET_H__
#define __UQ_VECTOR_SET_H__

#include <uqEnvironment.h>
#include <uqDefines.h>

template <class V, class M>
class uqVectorSpaceClass;

template <class V, class M>
class uqVectorSetClass
{
public:
           uqVectorSetClass();
           uqVectorSetClass(const uqBaseEnvironmentClass& env,
                            const char*                   prefix,
                                  double                  volume);
  virtual ~uqVectorSetClass();

          const uqBaseEnvironmentClass&  env        ()                 const;
                double                   volume     ()                 const;
  virtual const uqVectorSpaceClass<V,M>& vectorSpace()                 const = 0;
  virtual       bool                     contains   (const V& vec)     const = 0;
  virtual       void                     print      (std::ostream& os) const;

protected:
  const uqBaseEnvironmentClass& m_env;
        std::string             m_prefix;
        double                  m_volume;
};

template <class V, class M>
uqVectorSetClass<V,M>::uqVectorSetClass()
  :
  m_env(*(new uqFullEnvironmentClass()))
{
  UQ_FATAL_TEST_MACRO(true,
                      m_env.rank(),
                      "uqVectorSetClass<V,M>::constructor(), default",
                      "should not be used by user");
}

template <class V, class M>
uqVectorSetClass<V,M>::uqVectorSetClass(
  const uqBaseEnvironmentClass& env,
  const char*                   prefix,
        double                  volume)
  :
  m_env   (env),
  m_prefix(prefix),
  m_volume(volume)
{
  if ((m_env.verbosity() >= 5) && (m_env.rank() == 0)) {
    std::cout << "Entering uqVectorSetClass<V,M>::constructor()"
              << std::endl;
  }

  if ((m_env.verbosity() >= 5) && (m_env.rank() == 0)) {
    std::cout << "Leaving uqVectorSetClass<V,M>::constructor()"
              << std::endl;
  }
}

template <class V, class M>
uqVectorSetClass<V,M>::~uqVectorSetClass()
{
  //std::cout << "Entering uqVectorSetClass<V,M>::destructor()"
  //          << std::endl;

  //std::cout << "Leaving uqVectorSetClass<V,M>::destructor()"
  //          << std::endl;
}

template <class V, class M>
const uqBaseEnvironmentClass&
uqVectorSetClass<V,M>::env() const
{
  return m_env;
}

template <class V, class M>
double
uqVectorSetClass<V,M>::volume() const
{
  return m_volume;
}

template <class V, class M>
void
uqVectorSetClass<V,M>::print(std::ostream& os) const
{
  return;
}

template<class V, class M>
std::ostream&
operator<<(std::ostream& os, const uqVectorSetClass<V,M>& obj)
{
  obj.print(os);

  return os;
}

#endif // __UQ_VECTOR_SET_H__

